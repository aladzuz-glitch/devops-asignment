import sys
import os

sys.path.append(os.path.dirname(os.path.dirname(__file__)))

from app import app


def test_health():

    response = app.test_client().get("/health")

    assert response.status_code == 200

    assert response.get_json() == {
        "status": "healthy"
    }

def test_home():

    response = app.test_client().get("/")

    assert response.status_code == 200

    data = response.get_json()

    assert data["project"] == "DevOps Assignment"


def test_version():

    response = app.test_client().get("/version")

    assert response.status_code == 200

    assert response.get_json() == {
        "version": "1.0.0",
        "environment": "dev"
    }


def test_config():

    response = app.test_client().get("/config")

    assert response.status_code == 200

    assert response.get_json() == {
        "environment": os.getenv("APP_ENV"),
        "owner": os.getenv("APP_OWNER"),
        "version": os.getenv("APP_VERSION")
    }
