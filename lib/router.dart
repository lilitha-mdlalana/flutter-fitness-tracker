import 'package:fitquest/presentation/screens/auth/login_screen.dart';
import 'package:fitquest/presentation/screens/auth/signup_screen.dart';
import 'package:fitquest/presentation/screens/home/home_screen.dart';

var routes = {
  '/login': (context) => LoginScreen(),
  '/signup': (context) => SignupScreen(),
  '/homepage':(context) => const HomeScreen(),
};