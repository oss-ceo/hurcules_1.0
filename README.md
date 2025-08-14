# Hurcules Web Application

A modern, scalable web application built with Flask and optimized for Google Cloud Platform deployment.

## 🚀 Features

- **Modern UI/UX**: Responsive design with Bootstrap 5 and custom animations
- **Cloud Ready**: Optimized for Google Cloud Platform (App Engine, Cloud Run)
- **API Endpoints**: RESTful API with health checks and data endpoints
- **Docker Support**: Containerized deployment with multi-stage builds
- **CI/CD Ready**: Google Cloud Build configuration for automated deployment
- **Testing**: Unit tests included
- **Security**: Environment-based configuration and security best practices

## 📁 Project Structure

```
hurcules_1.0/
├── app.py                 # Main Flask application
├── requirements.txt       # Python dependencies
├── app.yaml              # Google App Engine configuration
├── Dockerfile            # Docker container configuration
├── cloudbuild.yaml       # Google Cloud Build CI/CD
├── deploy.sh             # Deployment script
├── env.example           # Environment variables template
├── .dockerignore         # Docker ignore file
├── templates/            # HTML templates
│   ├── base.html         # Base template
│   ├── index.html        # Home page
│   ├── 404.html          # 404 error page
│   └── 500.html          # 500 error page
├── static/               # Static files
│   ├── css/
│   │   └── main.css      # Custom styles
│   └── js/
│       └── app.js        # Custom JavaScript
└── tests/                # Test files
    └── test_app.py       # Unit tests
```

## 🛠️ Local Development

### Prerequisites

- Python 3.9+
- pip
- Git

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd hurcules_1.0
   ```

2. **Create and activate virtual environment**
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Set up environment variables**
   ```bash
   cp env.example .env
   # Edit .env with your configuration
   ```

5. **Run the application**
   ```bash
   python app.py
   ```

6. **Access the application**
   - Open your browser and go to `http://localhost:8080`
   - Health check: `http://localhost:8080/api/health`
   - Data endpoint: `http://localhost:8080/api/data`

### Running Tests

```bash
python -m pytest tests/
# or
python tests/test_app.py
```

## ☁️ Google Cloud Deployment

### Option 1: Google App Engine (Recommended)

1. **Install Google Cloud SDK**
   ```bash
   # Download and install from: https://cloud.google.com/sdk/docs/install
   ```

2. **Authenticate and set project**
   ```bash
   gcloud auth login
   gcloud config set project YOUR_PROJECT_ID
   ```

3. **Deploy using the script**
   ```bash
   chmod +x deploy.sh
   ./deploy.sh
   ```

4. **Or deploy manually**
   ```bash
   gcloud app deploy app.yaml
   ```

### Option 2: Google Cloud Run

1. **Build and push Docker image**
   ```bash
   docker build -t gcr.io/YOUR_PROJECT_ID/hurcules-web-app .
   docker push gcr.io/YOUR_PROJECT_ID/hurcules-web-app
   ```

2. **Deploy to Cloud Run**
   ```bash
   gcloud run deploy hurcules-web-app \
     --image gcr.io/YOUR_PROJECT_ID/hurcules-web-app \
     --platform managed \
     --region us-central1 \
     --allow-unauthenticated \
     --port 8080
   ```

### Option 3: Automated CI/CD with Cloud Build

1. **Enable Cloud Build API**
   ```bash
   gcloud services enable cloudbuild.googleapis.com
   ```

2. **Set up Cloud Build trigger** (via Google Cloud Console or gcloud CLI)

3. **Push to trigger deployment**
   ```bash
   git push origin main
   ```

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `FLASK_ENV` | Flask environment | `development` |
| `SECRET_KEY` | Flask secret key | `dev-secret-key` |
| `PORT` | Application port | `8080` |

### App Engine Configuration

The `app.yaml` file configures:
- Python 3.9 runtime
- Automatic scaling (1-10 instances)
- Health checks
- Static file serving
- Environment variables

### Docker Configuration

The `Dockerfile` includes:
- Multi-stage build optimization
- Non-root user for security
- Health checks
- Gunicorn WSGI server

## 📊 API Endpoints

### Health Check
```
GET /api/health
```
Returns application health status.

**Response:**
```json
{
  "status": "healthy",
  "service": "hurcules-web-app",
  "version": "1.0.0"
}
```

### Data Endpoint
```
GET /api/data
```
Returns sample application data.

**Response:**
```json
{
  "message": "Hello from Hurcules Web App!",
  "timestamp": "2024-01-01T00:00:00Z"
}
```

## 🧪 Testing

Run the test suite:
```bash
python -m pytest tests/
```

Test coverage includes:
- Page loading
- API endpoints
- Error handling
- Static file serving

## 🔒 Security Considerations

- Environment-based configuration
- Secure secret management
- Non-root Docker containers
- HTTPS enforcement in production
- Input validation and sanitization

## 📈 Monitoring and Logging

- Google Cloud Logging integration
- Health check endpoints
- Application metrics
- Error tracking

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Check the [Google Cloud documentation](https://cloud.google.com/docs)
- Review Flask documentation
- Open an issue in this repository

---

**Built with ❤️ for Google Cloud Platform**
