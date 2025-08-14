# Google Cloud Platform Deployment Guide

This guide provides detailed instructions for deploying the Hurcules Web Application to various Google Cloud Platform services.

## 🎯 Deployment Options

### 1. Google App Engine (Recommended for beginners)
- **Best for**: Simple deployments, automatic scaling
- **Cost**: Pay-per-use, very cost-effective
- **Complexity**: Low

### 2. Google Cloud Run
- **Best for**: Containerized applications, event-driven scaling
- **Cost**: Pay-per-use, scales to zero
- **Complexity**: Medium

### 3. Google Compute Engine
- **Best for**: Full control, custom configurations
- **Cost**: Fixed pricing, always-on
- **Complexity**: High

## 🚀 Quick Start: App Engine Deployment

### Prerequisites

1. **Google Cloud Account**
   - Sign up at [cloud.google.com](https://cloud.google.com)
   - Enable billing

2. **Google Cloud SDK**
   ```bash
   # Download from: https://cloud.google.com/sdk/docs/install
   # Or use package manager:
   
   # Windows (with Chocolatey):
   choco install google-cloud-sdk
   
   # macOS (with Homebrew):
   brew install google-cloud-sdk
   
   # Linux (Ubuntu/Debian):
   echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
   curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
   sudo apt-get update && sudo apt-get install google-cloud-sdk
   ```

### Step-by-Step Deployment

1. **Initialize Google Cloud SDK**
   ```bash
   gcloud init
   ```

2. **Create a new project (optional)**
   ```bash
   gcloud projects create hurcules-web-app-$(date +%s)
   gcloud config set project hurcules-web-app-$(date +%s)
   ```

3. **Enable App Engine API**
   ```bash
   gcloud services enable appengine.googleapis.com
   ```

4. **Deploy the application**
   ```bash
   # Using the deployment script
   ./deploy.sh
   
   # Or manually
   gcloud app deploy app.yaml
   ```

5. **Access your application**
   ```bash
   gcloud app browse
   ```

## 🐳 Cloud Run Deployment

### Prerequisites

- Docker installed
- Google Cloud SDK configured

### Deployment Steps

1. **Build and push Docker image**
   ```bash
   # Set your project ID
   PROJECT_ID=$(gcloud config get-value project)
   
   # Build the image
   docker build -t gcr.io/$PROJECT_ID/hurcules-web-app .
   
   # Push to Container Registry
   docker push gcr.io/$PROJECT_ID/hurcules-web-app
   ```

2. **Deploy to Cloud Run**
   ```bash
   gcloud run deploy hurcules-web-app \
     --image gcr.io/$PROJECT_ID/hurcules-web-app \
     --platform managed \
     --region us-central1 \
     --allow-unauthenticated \
     --port 8080 \
     --memory 512Mi \
     --cpu 1 \
     --max-instances 10
   ```

3. **Access your application**
   ```bash
   gcloud run services describe hurcules-web-app --region us-central1 --format="value(status.url)"
   ```

## 🔄 Automated CI/CD with Cloud Build

### Setup

1. **Enable Cloud Build API**
   ```bash
   gcloud services enable cloudbuild.googleapis.com
   ```

2. **Grant Cloud Build permissions**
   ```bash
   # Get your project number
   PROJECT_NUMBER=$(gcloud projects describe $(gcloud config get-value project) --format="value(projectNumber)")
   
   # Grant Cloud Build Service Account the necessary roles
   gcloud projects add-iam-policy-binding $(gcloud config get-value project) \
     --member="serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com" \
     --role="roles/appengine.deployer"
   
   gcloud projects add-iam-policy-binding $(gcloud config get-value project) \
     --member="serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com" \
     --role="roles/storage.admin"
   ```

3. **Connect your repository**
   - Go to [Cloud Build Triggers](https://console.cloud.google.com/cloud-build/triggers)
   - Click "Connect Repository"
   - Choose your Git provider (GitHub, GitLab, etc.)
   - Select your repository

4. **Create a trigger**
   - Name: `hurcules-deploy`
   - Event: Push to a branch
   - Branch: `main`
   - Configuration: Cloud Build configuration file
   - Location: Repository

5. **Deploy automatically**
   ```bash
   git add .
   git commit -m "Deploy to Cloud Run"
   git push origin main
   ```

## 🔧 Configuration Options

### App Engine Configuration (`app.yaml`)

```yaml
runtime: python39
entrypoint: gunicorn -b :$PORT app:app

instance_class: F1  # F1 (free tier) or F2, F4 for paid

automatic_scaling:
  target_cpu_utilization: 0.65
  min_instances: 1
  max_instances: 10
  target_throughput_utilization: 0.6

env_variables:
  FLASK_ENV: production
  SECRET_KEY: "your-secret-key-here"

handlers:
  - url: /static
    static_dir: static
  - url: /.*
    script: auto
```

### Environment Variables

Set these in your deployment:

```bash
# For App Engine (in app.yaml)
env_variables:
  FLASK_ENV: production
  SECRET_KEY: "your-secret-key-here"

# For Cloud Run
gcloud run deploy hurcules-web-app \
  --set-env-vars FLASK_ENV=production,SECRET_KEY=your-secret-key-here
```

## 📊 Monitoring and Logging

### View Logs

```bash
# App Engine logs
gcloud app logs tail

# Cloud Run logs
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=hurcules-web-app" --limit=50
```

### Set up Monitoring

1. **Enable Cloud Monitoring**
   ```bash
   gcloud services enable monitoring.googleapis.com
   ```

2. **Create custom metrics** (optional)
   - Go to [Cloud Monitoring](https://console.cloud.google.com/monitoring)
   - Create custom dashboards
   - Set up alerts

## 🔒 Security Best Practices

### 1. Secret Management

```bash
# Use Secret Manager for sensitive data
echo -n "your-secret-key" | gcloud secrets create flask-secret-key --data-file=-

# Reference in app.yaml
env_variables:
  SECRET_KEY: "projects/$PROJECT_ID/secrets/flask-secret-key/versions/latest"
```

### 2. IAM Permissions

```bash
# Grant minimal required permissions
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com" \
  --role="roles/appengine.deployer"
```

### 3. HTTPS Enforcement

```bash
# App Engine automatically uses HTTPS
# For Cloud Run, HTTPS is enabled by default
```

## 💰 Cost Optimization

### App Engine
- Use F1 instances for development
- Set appropriate min/max instances
- Monitor usage in Cloud Console

### Cloud Run
- Scales to zero when not in use
- Set appropriate memory/CPU limits
- Use appropriate regions

## 🚨 Troubleshooting

### Common Issues

1. **Deployment fails**
   ```bash
   # Check logs
   gcloud app logs tail
   
   # Verify app.yaml syntax
   gcloud app deploy app.yaml --verbosity=debug
   ```

2. **Application not responding**
   ```bash
   # Check health endpoint
   curl https://your-app-url/api/health
   
   # Check instance status
   gcloud app instances list
   ```

3. **Static files not loading**
   - Verify `static/` directory structure
   - Check `app.yaml` handlers configuration
   - Ensure files are committed to repository

### Debug Commands

```bash
# Test locally
python app.py

# Check dependencies
pip list

# Verify Docker build
docker build -t test-image .

# Test Docker container
docker run -p 8080:8080 test-image
```

## 📚 Additional Resources

- [App Engine Documentation](https://cloud.google.com/appengine/docs)
- [Cloud Run Documentation](https://cloud.google.com/run/docs)
- [Cloud Build Documentation](https://cloud.google.com/build/docs)
- [Flask Documentation](https://flask.palletsprojects.com/)

## 🆘 Support

If you encounter issues:

1. Check the [Google Cloud Status Dashboard](https://status.cloud.google.com/)
2. Review application logs
3. Consult Google Cloud documentation
4. Open an issue in this repository

---

**Happy Deploying! 🚀** 