from app import app

def test_index():
    client = app.test_client()
    response = client.get('/')
    assert response.data == b"Hello from Jenkins Pipeline on GCP!"
