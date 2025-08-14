#!/bin/bash

# Local Development and Testing Script
# This script runs the application locally for testing

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_status "Starting Hurcules Web Application locally..."

# Check if Python is installed
if ! command -v python &> /dev/null; then
    print_error "Python is not installed. Please install Python 3.9+ first."
    exit 1
fi

# Check if requirements.txt exists
if [ ! -f "requirements.txt" ]; then
    print_error "requirements.txt not found. Please make sure you're in the correct directory."
    exit 1
fi

# Install dependencies if not already installed
print_status "Installing Python dependencies..."
pip install -r requirements.txt

# Set environment variables for local development
export FLASK_ENV=development
export FLASK_DEBUG=True
export SECRET_KEY=dev-secret-key-for-local-testing

print_status "Starting Flask application..."
print_status "Application will be available at: http://localhost:8080"
print_status "Health check: http://localhost:8080/api/health"
print_status "Press Ctrl+C to stop the application"

# Run the application
python app.py 