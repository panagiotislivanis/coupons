from flask import Blueprint, request, jsonify
from Models.user import User

register_bp = Blueprint('register', __name__)


@register_bp.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    username = data['username']
    password = data['password']

    User.register(username, password)

    return jsonify({'message': 'User registered successfully!'}), 201
