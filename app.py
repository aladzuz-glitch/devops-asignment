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
        "status": "broken"
    })

if __name__ == "__main__":
    app.run(debug=True)
