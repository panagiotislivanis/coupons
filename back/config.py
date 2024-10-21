import os


class Config:
    DB_HOST = os.getenv('DB_HOST', '165.232.121.221')
    DB_USER = os.getenv('DB_USER', 'panagiotis')
    DB_PASSWORD = os.getenv('DB_PASSWORD', 'BookLivanis2001@p')
    DB_NAME = os.getenv('DB_NAME', 'main')
