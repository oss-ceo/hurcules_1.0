#!/bin/bash

# Hurcules Web App Deployment Script
# This script deploys the application to Google Cloud Platform

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

# Check if gcloud is installed
if ! command -v gcloud &> /dev/null; then
    print_error "Google Cloud SDK is not installed. Please install it first."
    exit 1
fi

# Check if user is authenticated
if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q .; then
    print_warning "You are not authenticated with Google Cloud. Please run 'gcloud auth login' first."
    exit 1
fi

# Get project ID
PROJECT_ID=$(gcloud config get-value project 2>/dev/null)
if [ -z "$PROJECT_ID" ]; then
    print_error "No project ID set. Please run 'gcloud config set project YOUR_PROJECT_ID' first."
    exit 1
fi

print_status "Deploying to project: $PROJECT_ID"

# Check if app.yaml exists
if [ ! -f "app.yaml" ]; then
    print_error "app.yaml not found. Please make sure you're in the correct directory."
    exit 1
fi

# Check if requirements.txt exists
if [ ! -f "requirements.txt" ]; then
    print_error "requirements.txt not found. Please make sure you're in the correct directory."
    exit 1
fi

# Deploy to App Engine
print_status "Deploying to Google App Engine..."
gcloud app deploy app.yaml --project=$PROJECT_ID --quiet

if [ $? -eq 0 ]; then
    print_success "Deployment completed successfully!"
    
    # Get the app URL
    APP_URL=$(gcloud app browse --no-launch-browser --format="value(url)")
    print_success "Your app is available at: $APP_URL"
    
    # Show health check URL
    HEALTH_URL="$APP_URL/api/health"
    print_status "Health check endpoint: $HEALTH_URL"
    
else
    print_error "Deployment failed!"
    exit 1
fi

print_status "Deployment script completed." 