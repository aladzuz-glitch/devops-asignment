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

if __name__ == "__main__":
    app.run(debug=True)
