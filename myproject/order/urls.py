from django.urls import path
from . import views

app_name = "order"

urlpatterns = [
    path("", views.LandingView, name="landing"),
    path("address/", views.AddressView, name="address"),
    path("category/", views.CategoryView, name="category"),
    path("discount/", views.DiscountView, name="discount"),
    path("food/", views.FoodView, name="food"),
    path("user/", views.UserView, name="user"),
]
