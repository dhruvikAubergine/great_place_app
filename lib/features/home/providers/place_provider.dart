import 'package:flutter/foundation.dart';
import 'package:great_place_app/features/home/models/place.dart';

class PlaceProvider with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return _items;
  }
}
