
import 'package:geocoding/geocoding.dart';
import 'dart:math' show asin, cos, pi, pow, sin, sqrt;

class SupportingMethods{

  static Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      String formattedAddress =
          "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      return formattedAddress;
    } catch (e) {
      print("Error: $e");
      return '';
    }
  }


  static double calculateDistance({required double lat1, required double lon1,required  double lat2,required double lon2}) {
    const double radiusOfEarth = 6371000.0;
    double lat1Radians = _degreesToRadians(lat1);
    double lon1Radians = _degreesToRadians(lon1);
    double lat2Radians = _degreesToRadians(lat2);
    double lon2Radians = _degreesToRadians(lon2);
    double latDiff = lat2Radians - lat1Radians;
    double lonDiff = lon2Radians - lon1Radians;
    double a = pow(sin(latDiff / 2), 2) +
        cos(lat1Radians) * cos(lat2Radians) * pow(sin(lonDiff / 2), 2);
    double c = 2 * asin(sqrt(a));
    double distance = radiusOfEarth * c;
    return distance;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }




}