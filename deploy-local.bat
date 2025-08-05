@echo off
echo Starting Hurcules Web Application locally...

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed. Please install Python 3.9+ first.
    pause
    exit /b 1
)

REM Check if requirements.txt exists
if not exist "requirements.txt" (
    echo ERROR: requirements.txt not found. Please make sure you're in the correct directory.
    pause
    exit /b 1
)

REM Install dependencies
echo Installing Python dependencies...
pip install -r requirements.txt

REM Set environment variables for local development
set FLASK_ENV=development
set FLASK_DEBUG=True
set SECRET_KEY=dev-secret-key-for-local-testing

echo Starting Flask application...
echo Application will be available at: http://localhost:8080
echo Health check: http://localhost:8080/api/health
echo Press Ctrl+C to stop the application

REM Run the application
python app.py

pause 