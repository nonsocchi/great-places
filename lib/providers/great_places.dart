import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces extends ChangeNotifier {
  late List<Place> _places = [];

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

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dbList = await DBHelper.getData('user_places');

    _places = dbList
        .map(
          (place) => Place(
            id: place['id'],
            title: place['title'],
            location: null,
            image: File(
              place['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
