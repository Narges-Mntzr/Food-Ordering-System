from django.shortcuts import render
from django.db import connection

def run_query(query):
    with connection.cursor() as cursor:
        cursor.execute(query)
        result = cursor.fetchall()
    return result

def query_view(request):
    query = "SELECT * FROM dbo.category"
    data = run_query(query)
    context = {'data': data}
    return render(request, 'query_results.html', context)
