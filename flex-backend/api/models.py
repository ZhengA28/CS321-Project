from django.db import models
from django.contrib.auth.models import User 
from django.utils.timezone import now # for logging workout history

#create models here
class PresetExercise(models.Model):
    #workout
    name = models.CharField(max_length=30)
    description = models.TextField()
    tutorial_url = models.URLField(max_length=200)

    def __str__(self):
        return self.name

class CustomExercise(models.Model):
    # User created exercises
    user = models.ForeignKey(User, on_delete=models.CASCADE) #Tied to specific user
    name = models.CharField(max_length=30)
    description = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.name} Created by {self.user.username}"
    
class Workout(models.Model):
    #workout containing dynamic list of exercises
    user = models.ForeignKey(User, on_delete=models.CASCADE) #Tied to specific user
    title = models.CharField(max_length=50)
    exercises = models.ManyToManyField(
        PresetExercise, blank=True, related_name="workouts"
    ) #Preset exercises
    custom_exercises = models.ManyToManyField(
        CustomExercise, blank=True, related_name="workouts"
    ) #custom exercises ^
    date_created = models.DateTimeField(auto_now_add=True)
    workout_completed = models.DateTimeField(auto_now_add=True)
    date_completed = models.DateTimeField(blank=True, null=True, default=None) #set to none initially

    def mark_completed(self):
        self.workout_completed = True
        self.date_completed = now() #log current time
        self.save() #update database with time of completion
     
    def __str__(self):
        return f"{self.title} Created by {self.user.username}"


