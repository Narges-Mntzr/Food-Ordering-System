from .services import run_query

from django.shortcuts import render
from django.http import JsonResponse


def address_view(request):
    if request.method == "POST":
        data = request.POST

        postal_code = data.get("postal_code")
        title = data.get("title")
        city = data.get("city")
        street = data.get("street")
        phone_number = data.get("phone_number")
        latitude = data.get("latitude")
        longitude = data.get("longitude")

        # Validate the input data
        if not postal_code or not city or not street:
            return JsonResponse({"error": "Required fields are missing"}, status=400)

        try:
            run_query(
                """
                INSERT INTO address (postal_code, title, city, street, phone_number, latitude, longitude) 
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """,
                [postal_code, title, city, street, phone_number, latitude, longitude],
            )
        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    query = "SELECT postal_code, title, city, street, phone_number, latitude, longitude FROM address"
    data = run_query(query)
    context = {"data": data}
    return render(request, "address.html", context)
