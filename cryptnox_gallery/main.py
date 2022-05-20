import gzip
import io
import json
import tempfile
from pathlib import Path
from threading import Thread
import cryptnoxpy
import filetype
import requests
import wx
from wx._adv import Animation, AnimationCtrl
from wx import media
from pubsub import pub
import time
import random
from arc_gauge import ArcGauge
from datetime import datetime,timedelta

def url(metadata):
    try:
        metadata_json = json.loads(metadata)
    except json.decoder.JSONDecodeError:
        print("Error parsing metadata")
        return
    else:
        try:
            return metadata_json['image']
        except KeyError:
            try:
                return f"https://cf-ipfs.com/ipfs/{metadata_json['image_url'].split('/')[-2]}/{metadata_json['image_url'].split('/')[-1]}"
            except (KeyError, IndexError):
                pass


def scale_bitmap(bitmap, width, height):
    image = wx.ImageFromBitmap(bitmap)
    image = image.Scale(width, height, wx.IMAGE_QUALITY_HIGH)
    result = wx.BitmapFromImage(image)

    return result


def size(width, height, max_width, max_height):
    target_ratio = max_height / max_width
    im_ratio = height / width 
    if target_ratio > im_ratio:
        resize_width = max_width
        resize_height = round(resize_width * im_ratio)
    else:
        resize_height = max_height
        resize_width = round(resize_height / im_ratio)

    return resize_width, resize_height


class ScaleImageThread(Thread):
    def __init__(self, image_content: bytes, max_width: int, max_height: int):
        super(ScaleImageThread, self).__init__()
        self._image_content = image_content
        self.max_width: int = max_width
        self.max_height: int = max_height

        self.start()

    def run(self):
        img = wx.Image(io.BytesIO(self._image_content)).ConvertToBitmap()
        target_width, target_height = size(img.GetWidth(), img.GetHeight(),
                                           self.max_width, self.max_height)
        img = scale_bitmap(img, target_width, target_height)

        wx.CallAfter(pub.sendMessage, "finished", img=img)


class Panel(wx.Panel):
    def __init__(self, parent, id):
        wx.Panel.__init__(self, parent, id)
        self.SetBackgroundColour('black')
        self.SetForegroundColour('white')
        self.image = None
        self.card_inserted = False
        self.display_state = False
        self.animating = False
        self.display_size = wx.DisplaySize()
        self.main = wx.BoxSizer(wx.HORIZONTAL)
        self.taskbar = wx.BoxSizer(wx.VERTICAL)
        self.gauge = ArcGauge(self,size=(150,150))
        # self.gauge.SetValue(0)
        self.taskbar.Add(self.gauge,0,wx.CENTER)
        self.gauge.Hide()
        self.gauge.SetLabelText("Text here")
        self.text = wx.StaticText(self, label="Application ready")
        self.taskbar.Add(self.text, 0, wx.CENTER)
        main_sizer = wx.BoxSizer(wx.VERTICAL)
        self.Bind(wx.EVT_KEY_DOWN, self.on_key_down)
        

        main_sizer.Add((0, 0), 1, wx.EXPAND)
        main_sizer.Add(self.main, 0, wx.CENTER)
        main_sizer.Add((0, 0), 1, wx.EXPAND)
        main_sizer.Add(self.taskbar, 0, wx.CENTER)

        self.SetSizerAndFit(main_sizer)

        self.set_logo(True)

        self._serial = None
        self._dots = 1
        self.download_progress = 0

        pub.subscribe(self.update_progress, "update")
        pub.subscribe(self.downloaded, "downloaded")
        pub.subscribe(self.finished, "finished")

    
    def reset_to_main(self,text='Application ready',serial=False):
        self.text.SetLabel(text)
        # self.Layout()
        if self.animating:
            self.anim.Stop()
            self.animating = False
        self.display_state = False
        self.main.Clear(1)
        self.set_logo(True)
        if serial:
            self._serial = None

    def on_key_down(self,event: wx.EVT_KEY_DOWN):
        print(f'Key: {event.GetKeyCode()}')
        if event.GetKeyCode() == 70:
            if self.Parent.IsFullScreen():
                self.Parent.ShowFullScreen(0)
            else:
                self.Parent.ShowFullScreen(1)
            


    def set_logo(self, force: bool = False):
        if not force and not self._serial:
            return

        # self.text.SetLabel("Application ready")
        self.main.Clear(1)
        if not self.image:
            path = Path(__file__).parent.joinpath("cryptnox_transparent.png").absolute()
            img = wx.Image(str(path),wx.BITMAP_TYPE_PNG)
            img_size = (self.display_size[1]/1.67,self.display_size[1]/1.67)
            img = img.Scale(int(img_size[0]),int(img_size[1]),wx.IMAGE_QUALITY_HIGH)
            img = img.ConvertToBitmap()
            panel_width = self.Size[0]
            panel_height = self.Size[1]
            start_height = int((panel_height - img.GetHeight()) / 2)
            start_width = int((panel_width - img.GetWidth()) / 2)
            self.image = wx.StaticBitmap(self, wx.ID_ANY, img, (start_width, start_height))
        self.main.Add(self.image, 0, wx.CENTER, 0)
        self.screen_saver = True
        self.Layout()
        ScreenSaverThread(self)

    def move_image(self,coordinates):
        self.image.Move(coordinates)

    def delayed_serial_reset(self,wait=3):
        time.sleep(wait)
        self._serial = None

    def set_nft(self):
        try:
            connection = cryptnoxpy.Connection()
            card = cryptnoxpy.factory.get_card(connection)
            if card.type == ord("N") and self._serial != card.serial_number:
                print(f'--{datetime.now().strftime("%H:%M:%S")}--New card detected {card.serial_number}')
                self.card_inserted = True
                if self.display_state:
                    self.reset_to_main("Card found, Loading")
                self._serial = card.serial_number
                image_url = url(gzip.decompress(card.user_data[3]))
                header = requests.head(image_url)
                self.file_size = int(int(header.headers["content-length"]) / 1024)
                self.gauge.setRange(0,self.file_size)
                self.gauge.Show()
                self.Layout()
                DownloadThread(self,image_url, self.file_size)
            elif card.type == ord("N") and self._serial == card.serial_number:
                print("Same card detected")
                if not self.card_inserted:
                    if self.display_state:
                        self.reset_to_main("Application ready")
                        wx.CallLater(3000,self.delayed_serial_reset)
        except Exception as e:
            if 'Connection issue' == str(e):
                print('Connection issue or No card, passed')
            elif 'no card' in str(e):
                print(f'Ejected: {e}')
                self.card_inserted = False
                NFT_Expiration_Timer(self)
            elif 'Invalid URL' in str(e):
                print(f'Invalid: {e}')
                RetryThread(self)
            else:
                print(f'Exception {e}')
                self._serial = None
        wx.CallLater(500, self.set_nft)
    
    def show_waiting_image(self):
        path = Path(__file__).parent.joinpath("cryptnox_transparent.png").absolute()
        img = wx.Image(str(path),wx.BITMAP_TYPE_PNG)
        img_size = (self.Size[1],self.Size[1])
        img = img.Scale(img_size[0],img_size[1],wx.IMAGE_QUALITY_HIGH)
        img = img.ConvertToBitmap()
        start_width = (22.3/100)*self.Size[0]
        start_height = (1.5/100)*self.Size[1]
        st_bitmap = wx.StaticBitmap(self,1,img,(start_width,-start_height))
        st_bitmap = st_bitmap.SetBackgroundColour(wx.Colour(13,0,98,255))
        self.main.Clear()
        self.main.Add(st_bitmap,0,wx.Center,0)

    def finished(self, img):
        self.text.SetLabel("NFT loaded")
        start_height = int((self.Size[1] - img.GetHeight()) / 2)
        start_width = int((self.Size[0] - img.GetWidth()) / 2)
        nft = wx.StaticBitmap(self, -1, img, (start_width, start_height))
        self.main.Clear(1)
        self.main.Add(nft, 1, wx.CENTER)

    def update_progress(self):
        dots = " ." * self._dots
        self._dots += 1
        if self._dots % 5 == 0:
            self._dots = 1
        progress = (self.download_progress/self.file_size)*100
        self.gauge.setText=f"{progress}%"
        # self.text.SetLabel(f"Card found. Loading {round(progress,2)}%")

    def downloaded(self, data):
        try:
            file_type = filetype.guess(data).mime
            if not file_type.startswith('image'):
                self.text.SetLabel("File format not recognized. Can't display.")
                return
            if file_type.endswith('gif'):
                self._set_animation(data)
                self.display_state = True
                self.animating = True
            else:
                ScaleImageThread(data, self.Size[0], self.Size[1])
                self.display_state = True
            self.screen_saver = False
            self.gauge.SetValue(0)
            self.gauge.Hide()
            self.Layout()
            self.text.SetLabel("NFT loaded")
        except Exception as e:
            print(f'Exception in downloaded: {e}')
            RetryThread(self)
        

    def _set_animation(self, data):
        ft = tempfile.NamedTemporaryFile(delete=False, suffix=".gif")
        ft.write(data)
        ft.flush()
        ft.close()
        anim = Animation(ft.name)
        panel_width = self.Size[0]
        panel_height = self.Size[1]
        target_width, target_height = size(anim.Size[0], anim.Size[1], self.Size[0], self.Size[1])
        start_height = int((panel_height - target_height) / 2)
        start_width = int((panel_width - target_width) / 2)
        self.main.Clear(1)
        self.anim = media.MediaCtrl(self,-1,style=wx.SIMPLE_BORDER,pos=(start_width,start_height), size=(target_width,target_height))
        # self.anim.Bind(media.EVT_MEDIA_STOP, self.on_media_stop)
        self.anim.Bind(media.EVT_MEDIA_LOADED, self.on_media_loaded)
        self.anim.Bind(media.EVT_MEDIA_FINISHED,self.on_media_finished)
        self.anim.Load(ft.name)
        self.main.Add(self.anim, 0, wx.CENTER, 0)
        self.anim.Bind(wx.EVT_KEY_DOWN, self.on_key_down)

    def on_media_loaded(self, event):
        self.anim.Play()


    def on_media_finished(self,event: media.EVT_MEDIA_FINISHED):
        if self.animating:
            self.anim.Play()


class DownloadThread(Thread):
    def __init__(self,panel: Panel, image_url: str, file_size: int):
        super(DownloadThread, self).__init__()
        self.panel = panel
        self.file_size: int = file_size
        self.url: str = image_url
        self.panel.download_progress = 0

        self.data = b""
        self.start()

    def run(self):
        try:
            req = requests.get(self.url, stream=True)
            total_size = 0
            for byte in req.iter_content(chunk_size=1024):
                if byte:
                    self.data += byte
                total_size += len(byte)
                if total_size/1024 < self.file_size:
                    self.panel.download_progress = total_size/1024
                    self.panel.gauge.setValue(total_size/1024)
                    wx.CallAfter(pub.sendMessage, "update")
            self.panel.gauge.setValue(0)
            wx.CallAfter(pub.sendMessage, "downloaded", data=self.data)
        except Exception as e:
            print(f'Exception in downloading: {e}')
            RetryThread(self.panel)


class ScreenSaverThread(Thread):
    def __init__(self, panel: Panel, ):
        super(ScreenSaverThread,self).__init__()
        self.panel = panel
        self.start()

    def run(self):
        seconds = 0
        h_boundary = self.panel.display_size[0]-(self.panel.display_size[1]/1.2)
        v_boundary = self.panel.display_size[1]-((self.panel.display_size[1]/1.2)+50)
        while self.panel.screen_saver:
            if seconds <= 6.5:
                time.sleep(0.5)
                seconds += 0.5
                continue
            seconds = 0
            x = random.randrange(0,h_boundary)
            y = random.randrange(0,v_boundary)
            try:
                wx.CallAfter(self.panel.move_image,(x,y))
            except Exception as e:
                print(f'Error moving image: {e}')


class RetryThread(Thread):
    def __init__(self,panel: Panel):
        super(RetryThread,self).__init__()
        self.panel = panel
        self.panel.gauge.Hide()
        self.panel.Layout()
        self.start()

    def run(self):
        retry_seconds = 5
        while retry_seconds != 0:
            self.panel.text.SetLabel(f'NFT loading error, retrying in {retry_seconds}')
            retry_seconds -=1
            time.sleep(1)
        self.panel._serial = None


class NFT_Expiration_Timer(Thread):
    def __init__(self,panel: Panel):
        super(NFT_Expiration_Timer,self).__init__()
        self.panel = panel
        self.start()

    def run(self):
        minutes = 30
        start = datetime.now()
        while self.panel.display_state:
            time.sleep(0.5)
            end = datetime.now()
            diff = start - end
            if abs(int(diff.total_seconds())/60) >= minutes:
                print('Calling NFT expiration')
                wx.CallAfter(self.panel.reset_to_main,text="Application ready",serial=True)


class GalleryApp(wx.App):

    def __init__(self):
        super(GalleryApp, self).__init__()
        try:
            self.locale = wx.Locale(wx.LANGUAGE_ENGLISH)
        except:
            self.locale.setlocale(wx.locale.LC_ALL,('en_US','UTF-8'))
        self.frame = wx.Frame(None, -1, "Crytpnox Gallery")
        self.panel = Panel(self.frame, -1)
        self.frame.Show(1)
        self.frame.Maximize()
        self.frame.ShowFullScreen(1)
        wx.CallLater(0, self.panel.set_nft)
        self.MainLoop()

def main() -> None:
    app = GalleryApp()
    

if __name__ == '__main__':
    main()
