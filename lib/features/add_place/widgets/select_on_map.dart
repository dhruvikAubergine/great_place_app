import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:great_place_app/features/add_place/services/location_service.dart';
import 'package:latlong2/latlong.dart';

class SelectOnMap extends StatefulWidget {
  const SelectOnMap({super.key});
  static const routeName = '/current-location';

  @override
  State<SelectOnMap> createState() => _SelectOnMapState();
}

class _SelectOnMapState extends State<SelectOnMap> {
  LatLng pickedLocation = LocationService.instance.currentLocation;
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        centerTitle: true,
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: pickedLocation,
          onTap: (tapPosition, point) {
            _mapController.move(point, 13);
            setState(() {
              pickedLocation = point;
            });
          },
        ),
        children: [
          TileLayer(
            subdomains: const ['a', 'b', 'c'],
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80,
                height: 80,
                point: pickedLocation,
                builder: (BuildContext context) {
                  return const Icon(
                    Icons.location_on,
                    color: Colors.redAccent,
                  );
                },
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(pickedLocation);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
