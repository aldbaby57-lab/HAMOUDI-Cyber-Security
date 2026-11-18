
import os
import requests
from flask import Flask, request, jsonify

app = Flask(__name__)

BOT_TOKEN = os.environ.get("TELEGRAM_BOT_TOKEN")
APP_SECRET = os.environ.get("HAMOUDI_APP_SECRET")
OWNER_CHAT_ID = os.environ.get("HAMOUDI_OWNER_CHAT")


@app.route("/", methods=["GET"])
def home():
    return jsonify({
        "app": "HAMOUDI Cyber Security",
        "status": "running"
    })


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"})


@app.route("/telegram/notify", methods=["POST"])
def telegram_notify():
    if not BOT_TOKEN or not APP_SECRET or not OWNER_CHAT_ID:
        return jsonify({"error": "Server not configured"}), 503

    if request.headers.get("Authorization") != f"Bearer {APP_SECRET}":
        return jsonify({"error": "Unauthorized"}), 401

    data = request.get_json(silent=True) or {}
    message = data.get("message", "")

    if not isinstance(message, str) or not message.strip():
        return jsonify({"error": "Message required"}), 400

    if len(message) > 3000:
        return jsonify({"error": "Message too long"}), 400

    try:
        response = requests.post(
            f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage",
            json={"chat_id": OWNER_CHAT_ID, "text": message},
            timeout=15
        )
        response.raise_for_status()
        return jsonify({"status": "sent"})

    except requests.RequestException:
        return jsonify({"error": "Telegram connection failed"}), 502


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=int(os.environ.get("PORT", 8080))
    )
