from django.urls import path
from .views import get_users, create_user, get_preset_exercises


urlpatterns = [
    path('users/', get_users, name='get_users'),
    path('users/create/', create_user, name='create_user'),
    path('preset_exercises/', get_preset_exercises, name='preset_exercises')
]