from django.urls import path
from .views import get_users,login_user, create_user, get_preset_exercises, create_workout, get_user_workout, mark_workout_complete

# map views to URL endpoints
urlpatterns = [
    path('users/', get_users, name='get_users'),  # GET: Fetch all users
    path('users/create/', create_user, name='create_user'),  # POST: Create a new user
    path('preset-exercises/', get_preset_exercises, name='get_preset_exercises'),  # GET: Fetch all preset exercises
    path('workouts/create/', create_workout, name='create_workout'),  # POST: Create a workout for the logged-in user
    path('workouts/', get_user_workout, name='get_user_workout'),  # GET: Fetch all workouts for the logged-in user
    path('workouts/<int:workout_id>/complete/', mark_workout_complete, name='mark_workout_complete'),
    path('login/', login_user, name='login_user'),  
]
