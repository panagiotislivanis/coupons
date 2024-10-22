from flask import Blueprint, request, jsonify
from Models.user import User

login_bp = Blueprint('login', __name__)


@login_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data['username']
    password = data['password']
    if User.login(username, password):
        if User.IsAdmin(username):
            return jsonify({"success": True, "role": True})
        else:
            return jsonify({"success": True, "role": False})

    else:
        return jsonify({"success": False, "message": "Invalid credentials"}), 401
