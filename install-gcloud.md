# Google Cloud SDK Installation Guide

This guide will help you install the Google Cloud SDK on your system so you can deploy your Hurcules Web Application to Google Cloud Platform.

## 🪟 Windows Installation

### Option 1: Using Chocolatey (Recommended)

1. **Install Chocolatey** (if not already installed)
   ```powershell
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

2. **Install Google Cloud SDK**
   ```powershell
   choco install google-cloud-sdk
   ```

3. **Restart your terminal/PowerShell**

### Option 2: Manual Installation

1. **Download the installer**
   - Go to: https://cloud.google.com/sdk/docs/install
   - Download the Windows installer

2. **Run the installer**
   - Double-click the downloaded `.exe` file
   - Follow the installation wizard

3. **Initialize gcloud**
   ```cmd
   gcloud init
   ```

## 🍎 macOS Installation

### Option 1: Using Homebrew (Recommended)

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Google Cloud SDK
brew install google-cloud-sdk
```

### Option 2: Manual Installation

```bash
# Download and install
curl https://sdk.cloud.google.com | bash

# Restart your shell
exec -l $SHELL

# Initialize gcloud
gcloud init
```

## 🐧 Linux Installation (Ubuntu/Debian)

### Option 1: Using Package Manager

```bash
# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Update and install the SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk
```

### Option 2: Manual Installation

```bash
# Download and install
curl https://sdk.cloud.google.com | bash

# Restart your shell
exec -l $SHELL

# Initialize gcloud
gcloud init
```

## 🔧 Post-Installation Setup

### 1. Initialize Google Cloud SDK

```bash
gcloud init
```

This will:
- Open a browser window for authentication
- Ask you to select or create a Google Cloud project
- Set default compute region and zone

### 2. Verify Installation

```bash
# Check gcloud version
gcloud version

# List available projects
gcloud projects list

# Check current configuration
gcloud config list
```

### 3. Enable Required APIs

```bash
# Enable App Engine API
gcloud services enable appengine.googleapis.com

# Enable Cloud Build API (for CI/CD)
gcloud services enable cloudbuild.googleapis.com

# Enable Cloud Run API (if using Cloud Run)
gcloud services enable run.googleapis.com
```

## 🚀 Alternative Deployment Options

If you don't want to install Google Cloud SDK, you have several alternatives:

### Option 1: Use Google Cloud Console (Web Interface)

1. **Go to Google Cloud Console**
   - Visit: https://console.cloud.google.com
   - Sign in with your Google account

2. **Create a new project**
   - Click on the project dropdown
   - Click "New Project"
   - Enter a project name and click "Create"

3. **Enable App Engine**
   - Go to App Engine in the left sidebar
   - Click "Create Application"
   - Choose your region and click "Create"

4. **Deploy using Cloud Shell**
   - Click the Cloud Shell icon (terminal icon) in the top right
   - Upload your files or clone from Git
   - Run: `gcloud app deploy app.yaml`

### Option 2: Use GitHub Actions (CI/CD)

1. **Push your code to GitHub**

2. **Create GitHub Actions workflow**
   Create `.github/workflows/deploy.yml`:
   ```yaml
   name: Deploy to Google Cloud
   
   on:
     push:
       branches: [ main ]
   
   jobs:
     deploy:
       runs-on: ubuntu-latest
       steps:
       - uses: actions/checkout@v2
       
       - name: Setup Google Cloud SDK
         uses: google-github-actions/setup-gcloud@v0
         with:
           project_id: ${{ secrets.GCP_PROJECT_ID }}
           service_account_key: ${{ secrets.GCP_SA_KEY }}
       
       - name: Deploy to App Engine
         run: gcloud app deploy app.yaml
   ```

3. **Set up secrets in GitHub**
   - Go to your repository settings
   - Add `GCP_PROJECT_ID` and `GCP_SA_KEY` secrets

### Option 3: Use Docker and Deploy to Other Platforms

1. **Build Docker image**
   ```bash
   docker build -t hurcules-web-app .
   ```

2. **Deploy to other platforms**
   - **Heroku**: `heroku container:push web`
   - **Railway**: Connect your GitHub repo
   - **Render**: Connect your GitHub repo
   - **DigitalOcean App Platform**: Connect your GitHub repo

## 🔍 Troubleshooting

### Common Issues

1. **"gcloud command not found"**
   - Restart your terminal after installation
   - Add Google Cloud SDK to your PATH

2. **Authentication issues**
   ```bash
   gcloud auth login
   gcloud auth application-default login
   ```

3. **Permission denied**
   ```bash
   # Grant necessary roles
   gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
     --member="user:YOUR_EMAIL" \
     --role="roles/appengine.deployer"
   ```

4. **API not enabled**
   ```bash
   gcloud services enable appengine.googleapis.com
   ```

### Getting Help

- **Google Cloud Documentation**: https://cloud.google.com/docs
- **Google Cloud Support**: https://cloud.google.com/support
- **Community Forums**: https://stackoverflow.com/questions/tagged/google-cloud-platform

## ✅ Verification

After installation, verify everything works:

```bash
# Test gcloud
gcloud version

# Test deployment (after setting up project)
gcloud app deploy app.yaml --dry-run
```

---

**Once Google Cloud SDK is installed, you can use the original `deploy.sh` script! 🚀** 