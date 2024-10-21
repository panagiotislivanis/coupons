from flask import Flask
from flask_cors import CORS
from Api.register import register_bp
from Api.login import login_bp
from config import Config

app = Flask(__name__)
app.config.from_object(Config)
CORS(app)

# Εγγραφή του Blueprint
app.register_blueprint(register_bp)
app.register_blueprint(login_bp)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
