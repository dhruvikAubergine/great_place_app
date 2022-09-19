import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:great_place_app/features/home/helpers/db_helpers.dart';
import 'package:great_place_app/features/home/models/place.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      title: pickedTitle,
      id: DateTime.now().toString(),
      image: pickedImage.path,
    );
    _items.add(newPlace);
    DBHelper.insert('user_places', {
      'id': newPlace.id!,
      'title': newPlace.title!,
      'image': newPlace.image!
    });
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'] as String,
            title: item['title'] as String,
            image: item['image'] as String,
          ),
        )
        .toList();
    notifyListeners();
  }
}
