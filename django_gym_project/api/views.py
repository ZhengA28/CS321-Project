from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import User, PresetExercise
from .serializer import UserSerializer, PresetExerciseSerializer

#each view must be mapped back to /api/urls.py
#lets define our endpoints
#Fetch data from data base and return it
@api_view(['GET'])
def get_users(request):
    users = User.objects.all() #unserialized objects list
    serializer = UserSerializer(users, many=True) #serialize data
    return Response(serializer.data) #return serialized data

@api_view(['POST'])
def create_user(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save() #save to our db
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def get_preset_exercises(request):
    exercises = PresetExercise.objects.all()
    serializer = PresetExerciseSerializer(exercises, many=True)
    return Response(serializer.data)