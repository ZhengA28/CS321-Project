# Flex Timer Backend

This is the backend for the Flex Timer project, built with Django and Django REST Framework (DRF). 

## Handles: 
  - User authentication
  - CRUD operations for workouts
  - Integration with the Flutter frontend.

## Setup:

1. **Clone the Repository:**
   ```bash
   git clone <repo-link>
   cd flex-backend
   ```
   - I would advise against replacing new files in a new Django project instead, it might act funky becuase migrations and such

2. **Create and Activate a Virtual Environment:**
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows : venv\Scripts\activate
   ```

3. **Install Dependencies:** (See requirements.txt)
   ```bash
   pip install -r requirements.txt
   ```

4. **Set Environment Variables:**
   - Create a `.env` file in the root directory and write to it the following:
     ```
     DJANGO_SECRET_KEY=<your-secret-key>
     ```
   - Replace `<your-secret-key>` with a key generated from this command:
     ```bash
     python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'
     ```

5. **Run Migrations:** (if needed)
   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

6. **Start the Testing Server:**
   ```bash
   python manage.py runserver
   ```
   The server will run on [http://3.139.72.184:8000](http://3.139.72.184:8000/) (for now).
   


## API Endpoints:
- prefix with : **'http://3.139.72.184:8000'**
- admin login example: http://3.139.72.184:8000/admin/login/?next=/admin/
<img width="692" alt="Screenshot 2024-12-04 at 8 30 55 PM" src="https://github.com/user-attachments/assets/c2cc1b84-2679-4fa6-9662-6f3d55f7512c">

### Authentication:
- **POST** `/api/login/`: Logs in a user.
- **POST** `/api/register/`: Registers a new user.

### Workouts:
- **GET** `/api/workouts/`: Retrieves all workouts for the logged-in user.
- **POST** `/api/workouts/`: Creates a new workout.
- **PATCH** `/api/workouts/<id>/complete`: Marks a workout as complete.

### Exercises:
- **GET** `/api/preset-exercises/`: Retrieves all preset exercises.
- **POST** `/api/custom-exercises/`: Adds a custom exercise.

## Notes:

### Testing:
- Use Postman or run:
  ```bash
  python manage.py test
  ```
  to test API endpoints.

## TO-DO:
- Security enhancement
- Integrate persistent login and authorization in the Flutter frontend.
- Integrate local preset exercise database info from flutter -> django preset_exercise database
