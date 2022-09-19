import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  LocationService._();

  static final LocationService _instance = LocationService._();

  static LocationService get instance => _instance;

  LatLng currentLocation = LatLng(0, 0);

  Future<void> initailizeLocation() async {
    currentLocation = await determinePosition();
  }

  Future<LatLng> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    final position = await Geolocator.getCurrentPosition();

    return LatLng(position.latitude, position.longitude);
  }
}
