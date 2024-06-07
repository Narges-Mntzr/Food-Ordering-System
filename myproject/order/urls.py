from django.urls import path
from . import views

app_name = "order"

urlpatterns = [
    path("", views.LandingView, name="landing"),
    path("aboutus/", views.AboutUsView, name="aboutus"),
    path("address/", views.AddressView, name="address"),
    path("category/", views.CategoryView, name="category"),
    path("customer/", views.CustomerView, name="customer"),
    path("discount/", views.DiscountView, name="discount"),
    path("driver/", views.DriverView, name="driver"),
    path("food/", views.FoodView, name="food"),
    path("restaurant/", views.RestaurantView, name="restaurant"),
    path("user/", views.UserView, name="user"),
]
