@echo off
echo Starting ClipSync Services...
echo.

echo Starting Download Service...
start "Download Service" cmd /k "cd apps\download-service && npm run dev:simple"

echo Starting ML Engine...
start "ML Engine" cmd /k "cd apps\ml-engine && python src/main.py"

echo Starting Web App...
start "Web App" cmd /k "cd apps\web && npm run dev"

echo.
echo All services started! Check the new terminal windows.
echo.
pause
