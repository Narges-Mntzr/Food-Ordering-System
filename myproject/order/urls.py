from django.urls import path
from . import views

app_name = "order"

urlpatterns = [
    path("", views.landing_view, name="landing"),
    path("address/", views.address_view, name="address"),
    path("category/", views.category_view, name="category"),
    path("discount/", views.discount_view, name="discount"),
    path("food/", views.food_view, name="food"),
]
