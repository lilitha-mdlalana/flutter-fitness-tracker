
# **FitQuest**  

FitQuest is a mobile fitness-tracking application designed to help users track their fitness activities, set goals, and monitor progress. With real-time location tracking, route mapping, and progress analytics, FitQuest makes achieving fitness goals engaging and efficient.  

## **Features**  

- **Real-Time Location Tracking**:  
  Tracks users' routes using GPS, displaying the path on an interactive map.  

- **Route Mapping**:  
  Visual representation of the user's workout route with markers for starting and ending points.  

- **Distance and Progress Tracking**:  
  Calculates total distance covered and provides analytics to track workout progress over time.  

- **Goals Management**:  
  Users can set and monitor fitness goals, including distance, duration, and calorie targets.  

- **Offline-First Functionality**:  
  Ensures users can access and save fitness data without requiring an internet connection, with automatic synchronization to Firebase when online.  

- **Cloud and Local Data Storage**:  
  Utilizes Firebase for cloud storage and SQFlite for local data storage, ensuring seamless user experience and data availability.  

## **Tech Stack**  

- **Frontend**: Flutter with Dart  
- **Mapping Library**: FlutterMap  
- **Backend**: Firebase for real-time database and authentication  
- **Local Storage**: SQFlite for offline-first capability  

## **Architecture**  

FitQuest is built using the **MVVM Clean Architecture**, ensuring a modular and scalable codebase:  

1. **Model**:  
   - Represents the core data, including workout statistics, user profiles, and goals.  
   - Handles data operations and communication with the repository layer.  

2. **ViewModel**:  
   - Manages UI-related data and state logic, ensuring a clear separation of concerns.  
   - Acts as a bridge between the View and Model layers.  

3. **View**:  
   - Displays data and interactions to the user using Flutter widgets.  
   - Responds to updates from the ViewModel.  

4. **Repository**:  
   - Abstracts data sources (Firebase and SQFlite) for easy integration and maintenance.  

## **Installation Instructions**  

1. **Clone the Repository**:  
   ```bash  
   git clone https://github.com/lilitha-mdlalana/FitQuest.git  
   ```  

2. **Navigate to the Project Directory**:  
   ```bash  
   cd FitQuest  
   ```  

3. **Install Dependencies**:  
   ```bash  
   flutter pub get  
   ```  

4. **Run the Application**:  
   - Use the following command to launch the app:  
     ```bash  
     flutter run  
     ```  

## **Usage**  

1. **Sign Up / Log In**:  
   - Create an account or log in to start using the app.  
2. **Start a Workout**:  
   - Begin tracking your fitness activity with real-time location and progress updates.  
3. **Set Fitness Goals**:  
   - Define your targets for distance, duration, or calories.  
4. **View Progress**:  
   - Check detailed analytics and visualizations of your fitness journey.  

## **Contributing**  

We welcome contributions to improve FitQuest!  

1. Fork the repository.  
2. Create a new branch:  
   ```bash  
   git checkout -b feature/YourFeatureName  
   ```  
3. Commit your changes:  
   ```bash  
   git commit -m "Add your message here"  
   ```  
4. Push to your branch:  
   ```bash  
   git push origin feature/YourFeatureName  
   ```  
5. Submit a pull request.  

## **License**  

FitQuest is licensed under the [MIT License](LICENSE).  
