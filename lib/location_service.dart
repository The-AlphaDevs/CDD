import 'dart:async';
import 'package:location/location.dart';
import 'user_location.dart';

class LocationService {
  UserLocation currentLocation;

  var location = Location();
  var lat;
  var long;

  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationController.stream;
  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      if (granted != null) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged().listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      } else {
        _locationController.add(UserLocation(
          latitude: null,
          longitude: null,
        ));
      }
    });
  }

  Future<UserLocation> getLocation() async {
    var userLocation = await location.getLocation();
    try {
      currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );

      lat = userLocation.latitude;
      long = userLocation.longitude;
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }

    return currentLocation;
  }
}
