import 'dart:async';

import 'package:fitquest/domain/repositories/map_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../core/enums/workout_type.dart';
import '../../data/models/workout_model.dart';

class HomeViewModel extends ChangeNotifier {
  final MapRepository _mapRepository;

  HomeViewModel(this._mapRepository);

  LatLng? currentLocation;
  bool _isRunning = false;
  DateTime? _startTime;
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  double _distance = 0.0;
  double _speed = 0.0;
  List<Position> _route = [];
  List<LatLng> _routeLatLng = [];

  List<LatLng> get routeLatLng => _routeLatLng;

  bool get isRunning => _isRunning;
  Duration get elapsed => _elapsed;
  double get distance => _distance;
  double get speed => _speed;
  List<Position> get route => _route;

  Future<void> loadUserLocation() async {
    try {
      final position = await _mapRepository.getCurrentPosition();
      currentLocation = LatLng(position.latitude, position.longitude);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void startRun() {
    _isRunning = true;
    _startTime = DateTime.now();
    _route.clear();
    _elapsed = Duration.zero;
    _distance = 0.0;
    _speed = 0.0;
    _routeLatLng.clear();

    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      _elapsed = DateTime.now().difference(_startTime!);
      notifyListeners();
    });

    _startTracking();
    notifyListeners();
  }

  void stopRun({bool clearState = false}) {
  _isRunning = false;
  _timer?.cancel();
  if (clearState) {
    _route.clear();
    _elapsed = Duration.zero;
    _distance = 0.0;
    _speed = 0.0;
    _routeLatLng.clear();
  }
  notifyListeners();
}


  Future<void> _startTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    await Geolocator.requestPermission();
    Geolocator.getPositionStream().listen((Position position) {
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);
      if (_route.isNotEmpty) {
        _distance += Geolocator.distanceBetween(
              _route.last.latitude,
              _route.last.longitude,
              position.latitude,
              position.longitude,
            ) /
            1000.0; // Convert meters to kilometers
          _speed = _elapsed.inSeconds > 0
            ? _distance / (_elapsed.inSeconds / 3600) // km/h
            : 0.0;
      }
      _route.add(position);
      _routeLatLng.add(currentLatLng);
      notifyListeners();
    });
  }

  void toggleTracking() {
    _isRunning = !_isRunning;
    notifyListeners();
  }

  Workout prepareWorkout(String routeSnapshot) {
    return Workout(
      title: '',
      type: WorkoutType.run, // Default to run; update in SaveScreen
      distance: _distance,
      duration: _elapsed,
      routeSnapshot: routeSnapshot,
      timestamp: DateTime.now(),
    );
  }
  
}
