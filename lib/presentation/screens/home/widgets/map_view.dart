import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:fitquest/core/constants/constants.dart';
import 'package:fitquest/core/enums/workout_type.dart';
import 'package:fitquest/presentation/screens/save_workout/save_workout_screen.dart';
import 'package:fitquest/presentation/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final GlobalKey _mapKey = GlobalKey();
  Uint8List? _mapSnapshot;

  final MapController _mapController = MapController();

  Future<void> _captureMapSnapshot() async {
    try {
      RenderRepaintBoundary boundary =
          _mapKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 1.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      setState(() {
        _mapSnapshot = byteData?.buffer.asUint8List();
      });
    } catch (e) {
      print("Error capturing map snapshot: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: Stack(
        children: [
          buildFlutterMap(viewModel,),
          buildStatsWrapper(viewModel, context),
        ],
      ),
    );
  }

  Positioned buildStatsWrapper(HomeViewModel viewModel, BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Duration
            Text(
              "Duration: ${viewModel.elapsed.inMinutes}:${(viewModel.elapsed.inSeconds % 60).toString().padLeft(2, '0')}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Distance and Speed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Distance
                Column(
                  children: [
                    Text(
                      "Distance",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${viewModel.distance.toStringAsFixed(2)} km",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Speed
                Column(
                  children: [
                    Text(
                      "Speed",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      " ${viewModel.speed.toStringAsFixed(2)} km/h",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                !viewModel.isRunning
                    ? CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green,
                        child: IconButton(
                          onPressed: () {
                            viewModel.toggleTracking();
                            viewModel.startRun();
                          },
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.red,
                        child: IconButton(
                          onPressed: () {
                            viewModel.stopRun();
                            viewModel.toggleTracking();
                            _captureMapSnapshot();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SaveWorkoutScreen(
                                  title: "",
                                  mapSnapshot: _mapSnapshot,
                                  type: WorkoutType.run,
                                  distance: viewModel.distance,
                                  duration: viewModel.elapsed,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.stop,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  RepaintBoundary buildFlutterMap(
      HomeViewModel viewModel) {
    return RepaintBoundary(
      key: _mapKey,
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter:
              viewModel.currentLocation ?? const LatLng(-33.851520, 18.544150),
          initialZoom: 15.0,
          interactionOptions:
              const InteractionOptions(flags: InteractiveFlag.all),
        ),
        children: [
          TileLayer(
            urlTemplate: Constants.URL_TEMPLATE,
            maxZoom: 19,
            additionalOptions: {
              'accessToken': Constants.ACCESS_TOKEN,
              'id': 'mapbox/streets-v11',
            },
            userAgentPackageName: "© Mapbox",
          ),
          CurrentLocationLayer(
            alignPositionOnUpdate: AlignOnUpdate.always,
            alignDirectionOnUpdate: AlignOnUpdate.never,
            style: const LocationMarkerStyle(
              marker: Icon(
                Icons.navigation,
                color: Colors.black,
              ),
            ),
          ),
          PolylineLayer(polylines: [
            Polyline(
              points: viewModel.routeLatLng,
              strokeWidth: 4.0,
              color: Colors.blue,
            )
          ]),
        ],
      ),
    );
  }
}
