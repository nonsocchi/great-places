import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces extends ChangeNotifier {
  final List<Place> _places = [];

  List<Place> get places => [..._places];

  void addPlace(String placeTitle, File? placeImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: placeTitle,
      location: null,
      image: placeImage!,
    );

    _places.add(newPlace);
    notifyListeners();
  }
}
