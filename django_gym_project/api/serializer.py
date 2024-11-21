#File that tells model how to metamorphasize into beutiful serial JSON file
from rest_framework import serializers
from .models import User, PresetExercise

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User #model to be transformed
        fields = '__all__' #attributes from model to be transformed

class PresetExerciseSerializer(serializers.ModelSerializer):
    class Meta:
        model = PresetExercise
        fields = '__all__'