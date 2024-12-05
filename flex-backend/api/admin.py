from django.contrib import admin
from .models import PresetExercise, Workout, CustomExercise

# Register your models here.
admin.site.register(PresetExercise)
admin.site.register(CustomExercise)
admin.site.register(Workout)
