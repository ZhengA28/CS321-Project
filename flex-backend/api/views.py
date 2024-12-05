from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework.decorators import api_view,permission_classes #api_view for api, permission for user authentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from .models import PresetExercise, Workout, CustomExercise
from django.shortcuts import get_object_or_404
from .serializer import UserSerializer, PresetExerciseSerializer, CustomExerciseSerializer, WorkoutSerializer

#each endpoint in view must be mapped back to /api/urls.py

@api_view(['POST'])
def login_user(request):
    '''
    Authenticate a user and return success
    '''
    username = request.data.get('username')
    password = request.data.get('password')
    if username is None or password is None:
        return Response({"error": "Both username and password are required."}, status=status.HTTP_400_BAD_REQUEST)
    user = authenticate(username=username, password=password)
    if user is not None:
        return Response({"message": "Login successful!", "user_id": user.id},status=status.HTTP_200_OK)
    return Response({"error": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED)


@api_view(['GET'])
def get_users(request):
    '''
    Fetch all users
    '''
    users = User.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def create_user(request):
    '''
    Create new user (registration purposes).
    '''
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save() #Built-in User DRF serializer compatibility
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
def get_preset_exercises(request):
    exercises = PresetExercise.objects.all()
    serializer = PresetExerciseSerializer(exercises, many=True)
    return Response(serializer.data)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def create_workout(request):
    '''
    Creates a workout for the currently logged-in user.
    '''
    user = request.user
    data = request.data
    print("Received data:", data)

    #Fetch workout details
    workout_name = data.get('title')
    preset_exercise_ids = data.get('preset_exercises', [])
    custom_exercise_ids = data.get('custom_exercises', [])

    if not workout_name:
        print("Workout title is missing!")
        return Response({"error:" " Workout title is required."},status=400)
    #Create workout 'instance'
    try:
        workout = Workout.objects.create(user=user, title=workout_name)
        print("Workout created:", workout)
    except Exception as e:
        print("Error creating workout:",e)
        return Response({"error": "Failed to create workout."}, status=400)

    # Add preset exercises
    for exercise_id in preset_exercise_ids:
        try:
            preset_exercise = PresetExercise.objects.get(id=exercise_id)
            workout.exercises.add(preset_exercise)
        except PresetExercise.DoesNotExist:
            return Response({"error:" f"Preset exercise ID {exercise_id} does not exist."}, status=400)
        
    # Add custom exercises
    for exercise_id in custom_exercise_ids:
        try:
            custom_exercise = CustomExercise.objects.get(id=exercise_id)
            workout.custom_exercises.add(custom_exercise)
        except CustomExercise.DoesNotExist:
            return Response({"error:" f"Custom exercise ID {exercise_id} does not exist."}, status=400)
    workout.save()
    return Response({"message": "Workout created successfully!", "workout_id": workout.id},status=status.HTTP_201_CREATED)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_user_workout(request):
    '''
    Retrieve all workouts for logged-in user.
    '''
    user = request.user
    workouts = Workout.objects.filter(user=user)
    serializer = WorkoutSerializer(workouts, many=True) #
    return Response(serializer.data)

@api_view(['PATCH'])
def mark_workout_complete(request,workout_id):
    workout = get_object_or_404(Workout, id=workout_id, user=request.user)
    workout.mark_completed()
    return Response({'message': "Workout marked as completed", "date_completed": workout.date_completed})
