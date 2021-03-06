# -*- mode: python ; coding: utf-8 -*-

import pathlib
import plistlib

from pathlib import Path

# CryptnoxCLI special config

data_include = [
    ('cryptnox_gallery/logo.png',
     '')
]

pkgs_remove = [
    'sqlite3',
    'tcl85',
    'tk85',
    '_sqlite3',
    '_tkinter',
    'libopenblas',
]

cryptnox_gallery_path = pathlib.Path("cryptnox_gallery").absolute()


def remove(pkgs):
    for pkg in pkgs:
        a.binaries = [x for x in a.binaries if not x[0].startswith(pkg)]


block_cipher = None

a = Analysis(['cryptnox_gallery/main.py'],
             pathex=[cryptnox_gallery_path],
             binaries=[],
             datas=data_include,
             hiddenimports=[],
             hookspath=[],
             runtime_hooks=[],
             excludes=['_gtkagg', '_tkagg', 'curses', 'pywin.debugger', 'pywin.debugger.dbgcon', 'pywin.dialogs', 'tcl',
                       'Tkconstants', 'Tkinter', 'libopenblas'],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
remove(pkgs_remove)
pyz = PYZ(a.pure, a.zipped_data,
          cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          a.binaries,
          a.zipfiles,
          a.datas,
          [],
          name='cryptnox-gallery',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          upx_exclude=[],
          runtime_tmpdir=None,
          console=False)
app = BUNDLE(exe,
             name='cryptnox-gallery.app',
             icon='cryptnox-gallery.icns',
             bundle_identifier=None)

app_path = Path(app.name)

with open(app_path / 'Contents/Info.plist', 'rb') as f:
    pl = plistlib.load(f)

with open(app_path / 'Contents/Info.plist', 'wb') as f:
    pl['CFBundleExecutable'] = 'wrapper'
    plistlib.dump(pl, f)

shell_script = """#!/bin/bash
dir=$(dirname $0)
open -a Terminal file://${dir}/%s""" % app.appname
with open(app_path / 'Contents/MacOS/wrapper', 'w') as f:
    f.write(shell_script)

(app_path / 'Contents/MacOS/wrapper').chmod(0o755)
