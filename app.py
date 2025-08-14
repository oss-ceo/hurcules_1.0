from flask import Flask, render_template, request, jsonify
import os
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

# Configuration
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')
app.config['DEBUG'] = os.environ.get('FLASK_ENV') == 'development'

@app.route('/')
def index():
    """Main page route"""
    return render_template('index.html')

@app.route('/api/health')
def health_check():
    """Health check endpoint for Google Cloud"""
    return jsonify({
        'status': 'healthy',
        'service': 'hurcules-web-app',
        'version': '1.0.0'
    })

@app.route('/api/data')
def get_data():
    """Example API endpoint"""
    return jsonify({
        'message': 'Hello from Hurcules Web App!',
        'timestamp': '2024-01-01T00:00:00Z'
    })

@app.errorhandler(404)
def not_found(error):
    return render_template('404.html'), 404

@app.errorhandler(500)
def internal_error(error):
    return render_template('500.html'), 500

if __name__ == '__main__':
    # Get port from environment variable for Google Cloud
    port = int(os.environ.get('PORT', 8080))
    
    # Run the app
    app.run(host='0.0.0.0', port=port, debug=app.config['DEBUG']) 