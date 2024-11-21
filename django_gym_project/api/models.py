from django.db import models

# Create models here.
class User(models.Model):
    #username
    username = models.CharField(max_length=15)


    def __str__(self):
        return self.username

class PresetExercise(models.Model):
    #workout
    name = models.CharField(max_length=30)
    description = models.TextField()
    tutorial_url = models.URLField(max_length=200)


    def __str__(self):
        return self.name
