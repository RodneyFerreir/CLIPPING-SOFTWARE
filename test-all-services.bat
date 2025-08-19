@echo off
echo 🚀 ClipSync Complete Service Testing Suite
echo ==========================================
echo.

echo 📋 Checking prerequisites...
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

REM Check if npm is installed
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ npm is not installed or not in PATH
    pause
    exit /b 1
)

echo ✅ Node.js and npm are available
echo.

REM Check if axios is available globally or install it
echo 📦 Checking for axios dependency...
node -e "require('axios')" >nul 2>&1
if %errorlevel% neq 0 (
    echo 📦 Installing axios globally...
    npm install -g axios
    if %errorlevel% neq 0 (
        echo ❌ Failed to install axios
        pause
        exit /b 1
    )
    echo ✅ Axios installed
    echo.
)

echo 🧪 Starting comprehensive service tests...
echo.

REM Run the comprehensive test suite
node test-all-services.js

echo.
echo 🏁 Testing completed
pause
