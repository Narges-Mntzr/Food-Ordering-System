import json

from datetime import datetime
from django.http import JsonResponse
from django.shortcuts import render

from .services import run_query


def LandingView(request):
    return render(request, "landing.html")


def AddressView(request):
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


def CategoryView(request):
    if request.method == "POST":
        data = request.POST

        name = data.get("name")

        try:
            run_query(
                """
                INSERT INTO category (name) 
                VALUES (%s)
            """,
                [name],
            )
        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    query = "SELECT id, name FROM category"
    data = run_query(query)
    context = {"data": data}
    return render(request, "category.html", context)


def DiscountView(request):
    if request.method == "POST":
        data = request.POST

        amount = data.get("amount")
        type = data.get("type")
        expire_time = data.get("expire_time")

        try:
            # Convert expire_time to the correct format
            expire_time = datetime.strptime(expire_time, "%Y-%m-%dT%H:%M")
            expire_time = expire_time.strftime("%Y-%m-%d %H:%M:%S")

            run_query(
                """
                INSERT INTO discount (amount, type, expire_time) 
                VALUES (%s, %s, %s)
            """,
                [amount, type, expire_time],
            )
        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    query = "SELECT discount_code, amount, type, expire_time FROM discount"
    data = run_query(query)
    formatted_data = [
        (item[0], item[1], item[2], item[3].strftime("%Y-%m-%dT%H:%M:%S"))
        for item in data
    ]

    query = "SELECT discount_code, amount, type, expire_time FROM available_discounts"
    available_data = run_query(query)
    formatted_available_data = [
        (item[0], item[1], item[2], item[3].strftime("%Y-%m-%dT%H:%M:%S"))
        for item in available_data
    ]

    context = {
        "data": json.dumps(formatted_data),
        "available_data": json.dumps(formatted_available_data),
    }
    return render(request, "discount.html", context)


def FoodView(request):
    if request.method == "POST":
        data = request.POST

        name = data.get("name")
        price = data.get("price")
        category = data.get("category")
        description = data.get("description")
        image = data.get("image")

        print(category)
        try:
            run_query(
                """
                INSERT INTO food (name, price, description, image, category_id)
                VALUES (%s, %s, %s, %s, %s)
            """,
                [name, price, description, image, category],
            )
        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    query = "SELECT f.id, f.name, price, c.name, description, image FROM food f JOIN category c ON (f.category_id=c.id)"
    data = run_query(query)

    query = "SELECT id,name FROM category"
    categories = run_query(query)

    context = {"data": data, "categories": categories}
    return render(request, "food.html", context)
