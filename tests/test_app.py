import unittest
import json
from app import app

class HurculesAppTestCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_index_page(self):
        """Test that the index page loads successfully"""
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b'Hurcules', response.data)

    def test_health_check(self):
        """Test the health check endpoint"""
        response = self.app.get('/api/health')
        self.assertEqual(response.status_code, 200)
        
        data = json.loads(response.data)
        self.assertEqual(data['status'], 'healthy')
        self.assertEqual(data['service'], 'hurcules-web-app')
        self.assertEqual(data['version'], '1.0.0')

    def test_data_endpoint(self):
        """Test the data endpoint"""
        response = self.app.get('/api/data')
        self.assertEqual(response.status_code, 200)
        
        data = json.loads(response.data)
        self.assertIn('message', data)
        self.assertIn('timestamp', data)
        self.assertEqual(data['message'], 'Hello from Hurcules Web App!')

    def test_404_error(self):
        """Test 404 error handling"""
        response = self.app.get('/nonexistent-page')
        self.assertEqual(response.status_code, 404)

    def test_static_files(self):
        """Test that static files are accessible"""
        response = self.app.get('/static/css/main.css')
        self.assertEqual(response.status_code, 200)

if __name__ == '__main__':
    unittest.main() 