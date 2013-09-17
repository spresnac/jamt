; JaMT - Just another E-Mail Tool
; Install Script for NSIS
; -------------------------------

; The name of the installer
Name "JaMT - Just another E-Mail Tool"

; The file to write
OutFile "JaMT_Setup_1.4.4.exe"

; The default installation directory
InstallDir $PROGRAMFILES\jamt

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\JaMT" "Install_Dir"

;---------------------------------
; Pages

Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;---------------------------------
; The stuff to install
Section "JaMT"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File /r e:\\projekte\\jamt\\upload_1.4.4\\pure\\*.*
  
  ; Write the installation path into the registry
  WriteRegStr HKLM Software\JaMT "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\JaMT" "DisplayName" "JaMT - Just another E-Mail Tool"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\JaMT" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\JaMT" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\JaMT" "NoRepair" 1
  WriteUninstaller "uninstall.exe"

  CreateDirectory "$SMPROGRAMS\JaMT"
  CreateShortCut "$SMPROGRAMS\JaMT\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\JaMT\jamt.lnk" "$INSTDIR\jamt.exe" "" "$INSTDIR\jamt.exe" 0
  
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\JaMT"
  DeleteRegKey HKLM SOFTWARE\JaMT

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\JaMT\*.*"

  ; Remove directories used
  RMDir "$SMPROGRAMS\JaMT"
  RMDir /r "$INSTDIR"

SectionEnd
