import 'package:firebase_core/firebase_core.dart';
import 'package:fitquest/core/theme/theme.dart';
import 'package:fitquest/data/datasources/local/database_helper.dart';
import 'package:fitquest/data/datasources/local/goal_dao.dart';
import 'package:fitquest/data/datasources/local/location_service.dart';
import 'package:fitquest/domain/repositories/goal_repository.dart';
import 'package:fitquest/domain/repositories/map_repository.dart';
import 'package:fitquest/domain/repositories/workout_repository.dart';
import 'package:fitquest/presentation/screens/auth/auth_gate.dart';
import 'package:fitquest/presentation/view_models/activity_view_model.dart';
import 'package:fitquest/presentation/view_models/goals_view_model.dart';
import 'package:fitquest/presentation/view_models/home_view_model.dart';
import 'package:fitquest/presentation/view_models/save_workout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/local/workout_dao.dart';
import 'data/datasources/remote/firebase_service.dart';
import 'domain/repositories/auth_repository.dart';
import 'firebase_options.dart';
import 'router.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseHelper.getDatabase();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider<WorkoutDAO>(
          create: (context) => WorkoutDAO(db),
        ),
        Provider<GoalDao>(
          create: (context) => GoalDao(db),
        ),
        Provider<FirebaseService>(
          create: (context) => FirebaseService(),
        ),
        ProxyProvider<FirebaseService, AuthRepository>(
          update: (context, firebaseService, _) =>
              AuthRepositoryImpl(firebaseService),
        ),
        Provider<MapRepository>(
          create: (context) => MapRepositoryImpl(LocationService()),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(context.read<MapRepository>()),
        ),
        ChangeNotifierProvider<SaveWorkoutViewModel>(
          create: (context) => SaveWorkoutViewModel(
            context.read<WorkoutDAO>(),
            context.read<FirebaseService>(),
          ),
        ),
        ProxyProvider2<WorkoutDAO, FirebaseService, SaveWorkout>(
          update: (context, workoutDAO, firebaseService, _) =>
              SaveWorkoutImpl(workoutDAO, firebaseService),
        ),
        ChangeNotifierProvider<ActivityViewModel>(
          create: (context) => ActivityViewModel(context.read<SaveWorkout>()),
        ),
        ChangeNotifierProvider<GoalsViewModel>(
          create: (context) => GoalsViewModel(
            GoalRepository(
              context.read<FirebaseService>(),
              context.read<GoalDao>(),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitQuest',
      theme: appTheme,
      home: FlutterSplashScreen.fadeIn(
          backgroundColor: Colors.grey.shade400,
          childWidget: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset("assets/logo/logo.png"),
          ),
          nextScreen: const AuthGate(),
          duration: const Duration(seconds: 5)),
      debugShowCheckedModeBanner: false,
      routes: routes,
    );
  }
}
