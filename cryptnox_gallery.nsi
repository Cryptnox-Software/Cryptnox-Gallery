; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Cryptnox Gallery"
!define PRODUCT_VERSION "1.1.0"
!define PRODUCT_PUBLISHER "Cryptnox SA"
!define PRODUCT_WEB_SITE "https://cryptnox.ch"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\cryptnox_gallery.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "cryptnox.ico"
!define MUI_UNICON "cryptnox.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "LICENSE"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN "$INSTDIR\cryptnox_gallery.exe"
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\README.md"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "CryptnoxGallery-setup.exe"
InstallDir "$PROGRAMFILES\Cryptnox Gallery"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR\aiohttp"
  SetOverwrite try
  File "dist\cryptnox_gallery\aiohttp\_helpers.cp39-win_amd64.pyd"
  File "dist\cryptnox_gallery\aiohttp\_http_parser.cp39-win_amd64.pyd"
  File "dist\cryptnox_gallery\aiohttp\_http_writer.cp39-win_amd64.pyd"
  File "dist\cryptnox_gallery\aiohttp\_websocket.cp39-win_amd64.pyd"
  SetOutPath "$INSTDIR"
  File "dist\cryptnox_gallery\api-ms-win-core-console-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-datetime-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-debug-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-errorhandling-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-fibers-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-file-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-file-l1-2-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-file-l2-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-handle-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-heap-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-interlocked-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-libraryloader-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-localization-l1-2-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-memory-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-namedpipe-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-processenvironment-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-processthreads-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-processthreads-l1-1-1.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-profile-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-rtlsupport-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-string-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-synch-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-synch-l1-2-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-sysinfo-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-timezone-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-core-util-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-conio-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-convert-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-environment-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-filesystem-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-heap-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-locale-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-math-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-multibyte-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-process-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-runtime-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-stdio-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-string-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-time-l1-1-0.dll"
  File "dist\cryptnox_gallery\api-ms-win-crt-utility-l1-1-0.dll"
  File "dist\cryptnox_gallery\arc_gauge.cpython-39.pyc"
  File "dist\cryptnox_gallery\arc_gauge.py"
  File "dist\cryptnox_gallery\base_library.zip"
  SetOutPath "$INSTDIR\certifi"
  File "dist\cryptnox_gallery\certifi\cacert.pem"
  SetOutPath "$INSTDIR"
  File "dist\cryptnox_gallery\cryptnox_gallery.exe"
  CreateDirectory "$SMPROGRAMS\Cryptnox Gallery"
  CreateShortCut "$SMPROGRAMS\Cryptnox Gallery\Cryptnox Gallery.lnk" "$INSTDIR\cryptnox_gallery.exe"
  CreateShortCut "$DESKTOP\Cryptnox Gallery.lnk" "$INSTDIR\cryptnox_gallery.exe"
  File "dist\cryptnox_gallery\cryptnox_transparent.png"
  SetOutPath "$INSTDIR\cryptography\hazmat\bindings"
  File "dist\cryptnox_gallery\cryptography\hazmat\bindings\_openssl.pyd"
  File "dist\cryptnox_gallery\cryptography\hazmat\bindings\_rust.pyd"
  SetOutPath "$INSTDIR\cryptography-36.0.2.dist-info"
  File "dist\cryptnox_gallery\cryptography-36.0.2.dist-info\INSTALLER"
  File "dist\cryptnox_gallery\cryptography-36.0.2.dist-info\LICENSE"
  File "dist\cryptnox_gallery\cryptography-36.0.2.dist-info\LICENSE.APACHE"
  File "dist\cryptnox_gallery\cryptography-36.0.2.dist-info\LICENSE.BSD"
  File "dist\cryptnox_gallery\cryptography-36.0.2.dist-info\LICENSE.PSF"
  File "dist\cryptnox_gallery\cryptography-36.0.2.dist-info\METADATA"
  File "dist\cryptnox_gallery\cryptography-36.0.2.dist-info\RECORD"
  File "dist\cryptnox_gallery\cryptography-36.0.2.dist-info\top_level.txt"
  File "dist\cryptnox_gallery\cryptography-36.0.2.dist-info\WHEEL"
  SetOutPath "$INSTDIR\frozenlist"
  File "dist\cryptnox_gallery\frozenlist\_frozenlist.cp39-win_amd64.pyd"
  SetOutPath "$INSTDIR"
  File "dist\cryptnox_gallery\libcrypto-1_1.dll"
  File "dist\cryptnox_gallery\libffi-7.dll"
  File "dist\cryptnox_gallery\libssl-1_1.dll"
  File "dist\cryptnox_gallery\logo.png"
  File "dist\cryptnox_gallery\main.py"
  File "dist\cryptnox_gallery\MSVCP140.dll"
  SetOutPath "$INSTDIR\multidict"
  File "dist\cryptnox_gallery\multidict\_multidict.cp39-win_amd64.pyd"
  SetOutPath "$INSTDIR\pubsub\core"
  File "dist\cryptnox_gallery\pubsub\core\annotations.py"
  File "dist\cryptnox_gallery\pubsub\core\callables.py"
  File "dist\cryptnox_gallery\pubsub\core\listener.py"
  File "dist\cryptnox_gallery\pubsub\core\notificationmgr.py"
  File "dist\cryptnox_gallery\pubsub\core\publisher.py"
  File "dist\cryptnox_gallery\pubsub\core\topicargspec.py"
  File "dist\cryptnox_gallery\pubsub\core\topicdefnprovider.py"
  File "dist\cryptnox_gallery\pubsub\core\topicexc.py"
  File "dist\cryptnox_gallery\pubsub\core\topicmgr.py"
  File "dist\cryptnox_gallery\pubsub\core\topicobj.py"
  File "dist\cryptnox_gallery\pubsub\core\topictreetraverser.py"
  File "dist\cryptnox_gallery\pubsub\core\topicutils.py"
  File "dist\cryptnox_gallery\pubsub\core\weakmethod.py"
  File "dist\cryptnox_gallery\pubsub\core\__init__.py"
  SetOutPath "$INSTDIR"
  File "dist\cryptnox_gallery\pyexpat.pyd"
  File "dist\cryptnox_gallery\python3.dll"
  File "dist\cryptnox_gallery\python39.dll"
  File "dist\cryptnox_gallery\select.pyd"
  SetOutPath "$INSTDIR\smartcard\scard"
  File "dist\cryptnox_gallery\smartcard\scard\_scard.cp39-win_amd64.pyd"
  SetOutPath "$INSTDIR"
  File "dist\cryptnox_gallery\ucrtbase.dll"
  File "dist\cryptnox_gallery\unicodedata.pyd"
  File "dist\cryptnox_gallery\VCRUNTIME140.dll"
  SetOutPath "$INSTDIR\wx"
  File "dist\cryptnox_gallery\wx\siplib.cp39-win_amd64.pyd"
  File "dist\cryptnox_gallery\wx\_adv.cp39-win_amd64.pyd"
  File "dist\cryptnox_gallery\wx\_core.cp39-win_amd64.pyd"
  File "dist\cryptnox_gallery\wx\_html.cp39-win_amd64.pyd"
  File "dist\cryptnox_gallery\wx\_media.cp39-win_amd64.pyd"
  File "dist\cryptnox_gallery\wx\_msw.cp39-win_amd64.pyd"
  SetOutPath "$INSTDIR"
  File "dist\cryptnox_gallery\wxbase315u_net_vc140_x64.dll"
  File "dist\cryptnox_gallery\wxbase315u_vc140_x64.dll"
  File "dist\cryptnox_gallery\wxmsw315u_core_vc140_x64.dll"
  File "dist\cryptnox_gallery\wxmsw315u_html_vc140_x64.dll"
  File "dist\cryptnox_gallery\wxmsw315u_media_vc140_x64.dll"
  SetOutPath "$INSTDIR\yarl"
  File "dist\cryptnox_gallery\yarl\_quoting_c.cp39-win_amd64.pyd"
  SetOutPath "$INSTDIR"
  File "dist\cryptnox_gallery\_asyncio.pyd"
  File "dist\cryptnox_gallery\_bz2.pyd"
  File "dist\cryptnox_gallery\_cffi_backend.cp39-win_amd64.pyd"
  File "dist\cryptnox_gallery\_ctypes.pyd"
  File "dist\cryptnox_gallery\_decimal.pyd"
  File "dist\cryptnox_gallery\_hashlib.pyd"
  File "dist\cryptnox_gallery\_lzma.pyd"
  File "dist\cryptnox_gallery\_multiprocessing.pyd"
  File "dist\cryptnox_gallery\_overlapped.pyd"
  File "dist\cryptnox_gallery\_queue.pyd"
  File "dist\cryptnox_gallery\_socket.pyd"
  File "dist\cryptnox_gallery\_ssl.pyd"
  File "dist\cryptnox_gallery\_uuid.pyd"
  File "dist\cryptnox_gallery\__init__.py"
  SetOverwrite ifnewer
  File "README.md"
SectionEnd

Section -AdditionalIcons
  CreateShortCut "$SMPROGRAMS\Cryptnox Gallery\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\cryptnox_gallery.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\cryptnox_gallery.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\README.md"
  Delete "$INSTDIR\__init__.py"
  Delete "$INSTDIR\_uuid.pyd"
  Delete "$INSTDIR\_ssl.pyd"
  Delete "$INSTDIR\_socket.pyd"
  Delete "$INSTDIR\_queue.pyd"
  Delete "$INSTDIR\_overlapped.pyd"
  Delete "$INSTDIR\_multiprocessing.pyd"
  Delete "$INSTDIR\_lzma.pyd"
  Delete "$INSTDIR\_hashlib.pyd"
  Delete "$INSTDIR\_decimal.pyd"
  Delete "$INSTDIR\_ctypes.pyd"
  Delete "$INSTDIR\_cffi_backend.cp39-win_amd64.pyd"
  Delete "$INSTDIR\_bz2.pyd"
  Delete "$INSTDIR\_asyncio.pyd"
  Delete "$INSTDIR\yarl\_quoting_c.cp39-win_amd64.pyd"
  Delete "$INSTDIR\wxmsw315u_media_vc140_x64.dll"
  Delete "$INSTDIR\wxmsw315u_html_vc140_x64.dll"
  Delete "$INSTDIR\wxmsw315u_core_vc140_x64.dll"
  Delete "$INSTDIR\wxbase315u_vc140_x64.dll"
  Delete "$INSTDIR\wxbase315u_net_vc140_x64.dll"
  Delete "$INSTDIR\wx\_msw.cp39-win_amd64.pyd"
  Delete "$INSTDIR\wx\_media.cp39-win_amd64.pyd"
  Delete "$INSTDIR\wx\_html.cp39-win_amd64.pyd"
  Delete "$INSTDIR\wx\_core.cp39-win_amd64.pyd"
  Delete "$INSTDIR\wx\_adv.cp39-win_amd64.pyd"
  Delete "$INSTDIR\wx\siplib.cp39-win_amd64.pyd"
  Delete "$INSTDIR\VCRUNTIME140.dll"
  Delete "$INSTDIR\unicodedata.pyd"
  Delete "$INSTDIR\ucrtbase.dll"
  Delete "$INSTDIR\smartcard\scard\_scard.cp39-win_amd64.pyd"
  Delete "$INSTDIR\select.pyd"
  Delete "$INSTDIR\python39.dll"
  Delete "$INSTDIR\python3.dll"
  Delete "$INSTDIR\pyexpat.pyd"
  Delete "$INSTDIR\pubsub\core\__init__.py"
  Delete "$INSTDIR\pubsub\core\weakmethod.py"
  Delete "$INSTDIR\pubsub\core\topicutils.py"
  Delete "$INSTDIR\pubsub\core\topictreetraverser.py"
  Delete "$INSTDIR\pubsub\core\topicobj.py"
  Delete "$INSTDIR\pubsub\core\topicmgr.py"
  Delete "$INSTDIR\pubsub\core\topicexc.py"
  Delete "$INSTDIR\pubsub\core\topicdefnprovider.py"
  Delete "$INSTDIR\pubsub\core\topicargspec.py"
  Delete "$INSTDIR\pubsub\core\publisher.py"
  Delete "$INSTDIR\pubsub\core\notificationmgr.py"
  Delete "$INSTDIR\pubsub\core\listener.py"
  Delete "$INSTDIR\pubsub\core\callables.py"
  Delete "$INSTDIR\pubsub\core\annotations.py"
  Delete "$INSTDIR\multidict\_multidict.cp39-win_amd64.pyd"
  Delete "$INSTDIR\MSVCP140.dll"
  Delete "$INSTDIR\main.py"
  Delete "$INSTDIR\logo.png"
  Delete "$INSTDIR\libssl-1_1.dll"
  Delete "$INSTDIR\libffi-7.dll"
  Delete "$INSTDIR\libcrypto-1_1.dll"
  Delete "$INSTDIR\frozenlist\_frozenlist.cp39-win_amd64.pyd"
  Delete "$INSTDIR\cryptography-36.0.2.dist-info\WHEEL"
  Delete "$INSTDIR\cryptography-36.0.2.dist-info\top_level.txt"
  Delete "$INSTDIR\cryptography-36.0.2.dist-info\RECORD"
  Delete "$INSTDIR\cryptography-36.0.2.dist-info\METADATA"
  Delete "$INSTDIR\cryptography-36.0.2.dist-info\LICENSE.PSF"
  Delete "$INSTDIR\cryptography-36.0.2.dist-info\LICENSE.BSD"
  Delete "$INSTDIR\cryptography-36.0.2.dist-info\LICENSE.APACHE"
  Delete "$INSTDIR\cryptography-36.0.2.dist-info\LICENSE"
  Delete "$INSTDIR\cryptography-36.0.2.dist-info\INSTALLER"
  Delete "$INSTDIR\cryptography\hazmat\bindings\_rust.pyd"
  Delete "$INSTDIR\cryptography\hazmat\bindings\_openssl.pyd"
  Delete "$INSTDIR\cryptnox_transparent.png"
  Delete "$INSTDIR\cryptnox_gallery.exe"
  Delete "$INSTDIR\certifi\cacert.pem"
  Delete "$INSTDIR\base_library.zip"
  Delete "$INSTDIR\arc_gauge.py"
  Delete "$INSTDIR\arc_gauge.cpython-39.pyc"
  Delete "$INSTDIR\api-ms-win-crt-utility-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-time-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-string-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-stdio-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-runtime-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-process-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-multibyte-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-math-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-locale-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-heap-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-filesystem-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-environment-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-convert-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-crt-conio-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-util-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-timezone-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-sysinfo-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-synch-l1-2-0.dll"
  Delete "$INSTDIR\api-ms-win-core-synch-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-string-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-rtlsupport-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-profile-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-processthreads-l1-1-1.dll"
  Delete "$INSTDIR\api-ms-win-core-processthreads-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-processenvironment-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-namedpipe-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-memory-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-localization-l1-2-0.dll"
  Delete "$INSTDIR\api-ms-win-core-libraryloader-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-interlocked-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-heap-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-handle-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-file-l2-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-file-l1-2-0.dll"
  Delete "$INSTDIR\api-ms-win-core-file-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-fibers-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-errorhandling-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-debug-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-datetime-l1-1-0.dll"
  Delete "$INSTDIR\api-ms-win-core-console-l1-1-0.dll"
  Delete "$INSTDIR\aiohttp\_websocket.cp39-win_amd64.pyd"
  Delete "$INSTDIR\aiohttp\_http_writer.cp39-win_amd64.pyd"
  Delete "$INSTDIR\aiohttp\_http_parser.cp39-win_amd64.pyd"
  Delete "$INSTDIR\aiohttp\_helpers.cp39-win_amd64.pyd"

  Delete "$SMPROGRAMS\Cryptnox Gallery\Uninstall.lnk"
  Delete "$DESKTOP\Cryptnox Gallery.lnk"
  Delete "$SMPROGRAMS\Cryptnox Gallery\Cryptnox Gallery.lnk"

  RMDir "$SMPROGRAMS\Cryptnox Gallery"
  RMDir "$INSTDIR\yarl"
  RMDir "$INSTDIR\wx"
  RMDir "$INSTDIR\smartcard\scard"
  RMDir "$INSTDIR\pubsub\core"
  RMDir "$INSTDIR\multidict"
  RMDir "$INSTDIR\frozenlist"
  RMDir "$INSTDIR\cryptography-36.0.2.dist-info"
  RMDir "$INSTDIR\cryptography\hazmat\bindings"
  RMDir "$INSTDIR\certifi"
  RMDir "$INSTDIR\aiohttp"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd