@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\IT-EMM\Desktop\Cleane.exe
REM BFCPEICON=C:\Program Files (x86)\Advanced BAT to EXE Converter v4.62\ab2econv462\icons\icon6.ico
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=0
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=1
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Cleaner
REM BFCPEVERDESC=For Cleaner Window Cachce
REM BFCPEVERCOMPANY=www.uleman.biz.id
REM BFCPEVERCOPYRIGHT=Copyright ami ade
REM BFCPEWINDOWCENTER=1
REM BFCPEDISABLEQE=0
REM BFCPEWINDOWHEIGHT=30
REM BFCPEWINDOWWIDTH=120
REM BFCPEWTITLE=Window Title
REM BFCPEOPTIONEND
@echo off
title Pembersih Sampah Windows - Optimal
color 0b

:: ============================================================
:: PENGECEKAN ADMINISTRATOR
:: ============================================================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Script ini memerlukan hak akses Administrator.
    echo [!] Mencoba menjalankan ulang sebagai Administrator...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo ============================================================
echo        MEMBERSIHKAN FILE SAMPAH SISTEM WINDOWS
echo ============================================================
echo.

:: 1. Membersihkan Folder Temp Windows
echo [+] Membersihkan Windows Temp (C:\Windows\Temp)...
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
for /d %%p in ("C:\Windows\Temp\*") do rd /s /q "%%p" >nul 2>&1

:: 2. Membersihkan Folder Temp User
echo [+] Membersihkan User Temp (%temp%)...
del /s /f /q "%temp%\*.*" >nul 2>&1
for /d %%p in ("%temp%\*") do rd /s /q "%%p" >nul 2>&1

:: 3. Membersihkan Prefetch
echo [+] Membersihkan Prefetch...
del /s /f /q "C:\Windows\Prefetch\*.*" >nul 2>&1
for /d %%p in ("C:\Windows\Prefetch\*") do rd /s /q "%%p" >nul 2>&1

:: 4. Membersihkan Windows Update Cache (SoftwareDistribution)
:: Menghentikan service sementara agar file bisa dihapus
echo [+] Membersihkan Windows Update Cache...
net stop wuauserv >nul 2>&1
del /s /f /q "C:\Windows\SoftwareDistribution\Download\*.*" >nul 2>&1
for /d %%p in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%p" >nul 2>&1
net start wuauserv >nul 2>&1

:: 5. Membersihkan Recycle Bin (Semua Drive Utama)
echo [+] Mengosongkan Recycle Bin...
for %%d in (C D E F) do (
    if exist "%%d:\$Recycle.Bin" (
        rd /s /q "%%d:\$Recycle.Bin" >nul 2>&1
    )
)

:: 6. Flush DNS (Mempercepat Koneksi)
echo [+] Membersihkan DNS Cache...
ipconfig /flushdns >nul 2>&1

echo [+] Membersihkan riwayat File Explorer dan Start Menu...

:: Menghapus shortcut file terbaru di folder Recent utama
del /F /Q "%APPDATA%\Microsoft\Windows\Recent\*"

:: Menghapus riwayat Automatic Destinations (Start Menu & Taskbar Jump Lists)
del /F /Q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*"

:: Menghapus riwayat Custom Destinations
del /F /Q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*"

echo.
echo Berhasil! Menbersihkan!

echo.
echo ============================================================a
echo  PEMBERSIHAN SELESAI!
echo  Beberapa file mungkin tidak terhapus karena sedang digunakan.
echo ============================================================
echo.
pause
exit