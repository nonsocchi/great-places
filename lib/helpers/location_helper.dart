// ignore: constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const API_KEY = 'AIzaSyCJICIzUsc9SktqVx7PtFleJQqXyDqa1nA';

class LocationHelper {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longtitude,
  }) =>
      'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$latitude,$longtitude&key=$API_KEY';

  static Future<String> getPlaceAddress(double lat, double long) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$API_KEY';

    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
