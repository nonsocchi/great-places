const API_KEY = 'AIzaSyCJICIzUsc9SktqVx7PtFleJQqXyDqa1nA';

class LocationHelper {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longtitude,
  }) =>
      'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longtitude&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$latitude,$longtitude&key=$API_KEY&signature=CtUrGh4g7L3LVbR1f_Ay5Op8ZNc=';
}
