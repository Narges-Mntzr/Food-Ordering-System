import hashlib

from django.db import connection

def run_query(query, params=[]):
    result = None
    with connection.cursor() as cursor:
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
            result = cursor.fetchall()

    return result

def sha256(data):
    return hashlib.sha256(data.encode('utf-8')).hexdigest()[:16]