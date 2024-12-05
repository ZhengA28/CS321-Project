from rest_framework.test import APITestCase, APIClient
from rest_framework import status
from django.contrib.auth.models import User
from .models import PresetExercise, CustomExercise, Workout


# To run tests : 'python manage.py test'

class WorkoutAPITestCase(APITestCase):

    def setUp(self):
        # Create a test user
        self.user = User.objects.create_user(username="testuser", password="testpassword")
        
        # Authenticate the user
        self.client = APIClient()
        self.client.login(username="testuser", password="testpassword")

        # Create some preset exercises
        self.preset1 = PresetExercise.objects.create(name="Squat", description="Leg exercise")
        self.preset2 = PresetExercise.objects.create(name="Deadlift", description="Back exercise")

        # Create a custom exercise for the user
        self.custom_exercise = CustomExercise.objects.create(
            user=self.user,
            name="Single-Leg Deadlift",
            description="Hamstring exercise",
        )
        
        # Create a workout for testing
        self.workout = Workout.objects.create(user=self.user, title="Test Workout")
        self.workout.exercises.add(self.preset1, self.preset2)
        self.workout.custom_exercises.add(self.custom_exercise)

        print("Preset exercises:", PresetExercise.objects.all())
        print("Custom exercises:", CustomExercise.objects.all())

    def test_login(self):
        # Test login endpoint
        response = self.client.post('/api/login/', {'username': 'testuser', 'password': 'testpassword'}, format='json')
        print("Login response:", response.data)  # Debugging
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data["message"], "Login successful!")

    def test_create_workout(self):
        # Define the workout data
        workout_data = {
            "title": "Leg Day Test",
            "preset_exercises": [self.preset1.id, self.preset2.id],
            "custom_exercises": [self.custom_exercise.id],
        }

            # Test workout creation endpoint
        response = self.client.post('/api/workouts/create/', workout_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data["message"], "Workout created successfully!")

        # Verify the workout was created in the database
        workout = Workout.objects.get(title="Leg Day Test",user=self.user)
        self.assertEqual(workout.user, self.user)
        self.assertIn(self.preset1, workout.exercises.all())
        self.assertIn(self.custom_exercise, workout.custom_exercises.all())
        
    
    def test_mark_workout_complete(self):
        url = f"/workouts/{self.workout.id}/complete/"
        response = self.client.patch(url)

        # Assertions to verify the API works correctly
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.workout.refresh_from_db()
        self.assertTrue(self.workout.completed)
        self.assertIsNotNone(self.workout.date_completed)

        ######## TESTS ######## 
         
        # Test workout creation endpoint
        response = self.client.post('/api/workouts/create/', workout_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data["message"], "Workout created successfully!")

        # Verify the workout was created in the database
        workout = Workout.objects.get(title="Leg Day")
        self.assertEqual(workout.user, self.user)
        self.assertIn(self.preset1, workout.exercises.all())
        self.assertIn(self.custom_exercise, workout.custom_exercises.all())

    def test_get_workouts(self):
        # Create a workout manually
        workout = Workout.objects.create(user=self.user, title="Leg Day")
        workout.exercises.add(self.preset1)
        workout.custom_exercises.add(self.custom_exercise)

        # Test retrieving workouts
        response = self.client.get('/api/workouts/')
        print("Response data:", response.data)  # Debugging the GET response
        self.assertEqual(response.status_code, status.HTTP_200_OK)

        # Verify the response data
        self.assertEqual(len(response.data), 2)
        self.assertIn(workout.title, [w['title'] for w in response.data])
