const googleAPiKey = 'AIzaSyCvA8WboDPBbMKjsqUScweQQtmwXpl2yXQ';

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$googleAPiKey';
  }
}
