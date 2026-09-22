import os
from flask import Flask, jsonify

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "message": "Zdravo Ajdine",
        "project": "DevOps Assignment"
    })

@app.route("/health")
def health():
    return jsonify({
        "status": "healthy"
    })

@app.route("/version")
def version():
    return jsonify({
        "version": "1.0.0",
        "environment": "dev"
    })

@app.route("/config")
def config():

    return jsonify({
        "environment": os.getenv("APP_ENV"),
        "owner": os.getenv("APP_OWNER"),
        "version": os.getenv("APP_VERSION")
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
