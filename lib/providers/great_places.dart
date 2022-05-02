import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces extends ChangeNotifier {
  late List<Place> _places = [];

  List<Place> get places => [..._places];

  Future<void> addPlace(
    String placeTitle,
    File? placeImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);

    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.latitude,
        address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: placeTitle,
      location: updatedLocation,
      image: placeImage!,
    );

    _places.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_long': newPlace.location!.longitude,
      'address': newPlace.location!.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dbList = await DBHelper.getData('user_places');

    _places = dbList
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            location: PlaceLocation(
              latitude: place['loc_lat'],
              longitude: place['loc_long'],
              address: place['address'],
            ),
            image: File(
              place['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
