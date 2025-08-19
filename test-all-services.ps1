# ClipSync Complete Service Testing Suite
Write-Host "🚀 ClipSync Complete Service Testing Suite" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "📋 Checking prerequisites..." -ForegroundColor Yellow
Write-Host ""

# Check if Node.js is installed
try {
    $nodeVersion = node --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Node.js is available: $nodeVersion" -ForegroundColor Green
    } else {
        throw "Node.js not found"
    }
} catch {
    Write-Host "❌ Node.js is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Node.js from https://nodejs.org/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if npm is installed
try {
    $npmVersion = npm --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ npm is available: $npmVersion" -ForegroundColor Green
    } else {
        throw "npm not found"
    }
} catch {
    Write-Host "❌ npm is not installed or not in PATH" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""

# Check if axios is available globally or install it
Write-Host "📦 Checking for axios dependency..." -ForegroundColor Yellow
try {
    node -e "require('axios')" 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Axios is available" -ForegroundColor Green
    } else {
        throw "Axios not found"
    }
} catch {
    Write-Host "📦 Installing axios globally..." -ForegroundColor Yellow
    try {
        npm install -g axios
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Axios installed" -ForegroundColor Green
        } else {
            throw "npm install failed"
        }
    } catch {
        Write-Host "❌ Failed to install axios" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
    Write-Host ""
}

Write-Host "🧪 Starting comprehensive service tests..." -ForegroundColor Yellow
Write-Host ""

# Run the comprehensive test suite
try {
    node test-all-services.js
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ All tests passed!" -ForegroundColor Green
    } else {
        Write-Host "❌ Some tests failed" -ForegroundColor Red
    }
} catch {
    Write-Host "❌ Test execution failed: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🏁 Testing completed" -ForegroundColor Cyan
Read-Host "Press Enter to exit"
