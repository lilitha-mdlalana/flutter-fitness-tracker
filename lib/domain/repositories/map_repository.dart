import 'package:fitquest/data/datasources/local/location_service.dart';
import 'package:geolocator/geolocator.dart';

abstract class MapRepository{
  Future<Position> getCurrentPosition();
}

class MapRepositoryImpl implements MapRepository{
  final LocationService _locationService;

  MapRepositoryImpl(this._locationService);


  @override
  Future<Position> getCurrentPosition() async {
    return await _locationService.getCurrentPosition();
  }

}