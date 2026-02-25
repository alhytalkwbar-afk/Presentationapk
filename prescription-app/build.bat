@echo off
chcp 65001 >nul

:: MediCare Pro Build Script for Windows
:: Builds Android APK using Capacitor

echo ======================================
echo   MediCare Pro - Build Script
echo ======================================
echo.

:: Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo Error: Node.js is not installed
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

echo [OK] Node.js is installed

:: Check if npm is installed
npm --version >nul 2>&1
if errorlevel 1 (
    echo Error: npm is not installed
    pause
    exit /b 1
)

echo [OK] npm is installed

:: Install dependencies
echo.
echo Installing dependencies...
call npm install

:: Check if Android platform exists
if not exist "android" (
    echo.
    echo Adding Android platform...
    call npx cap add android
)

:: Install SQLite plugin
echo.
echo Installing SQLite plugin...
call npm install @capacitor-community/sqlite

:: Sync Capacitor
echo.
echo Syncing Capacitor...
call npx cap sync

echo.
echo ======================================
echo   Setup Complete!
echo ======================================
echo.
echo To build the APK, you have two options:
echo.
echo 1. Build using Android Studio (Recommended):
echo    npx cap open android
echo.
echo 2. Build using command line:
echo    cd android
echo    .\gradlew.bat assembleDebug
echo.
echo The APK will be located at:
echo    android\app\build\outputs\apk\debug\app-debug.apk
echo.

:: Ask if user wants to open Android Studio
set /p open_studio="Do you want to open Android Studio now? (y/n) "
if /i "%open_studio%"=="y" (
    call npx cap open android
)

pause
