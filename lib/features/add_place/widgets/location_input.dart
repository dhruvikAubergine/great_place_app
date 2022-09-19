import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:great_place_app/features/add_place/services/location_service.dart';
import 'package:great_place_app/features/add_place/widgets/select_on_map.dart';
import 'package:latlong2/latlong.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
  });

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LatLng? pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: pickedLocation == null
              ? const Text('No Location Chosen')
              : FlutterMap(
                  options: MapOptions(
                    center: pickedLocation,
                  ),
                  children: [
                    TileLayer(
                      subdomains: const ['a', 'b', 'c'],
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80,
                          height: 80,
                          point: pickedLocation!,
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
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                setState(
                  () =>
                      pickedLocation = LocationService.instance.currentLocation,
                );
              },
              label: Text(
                'Current Location',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              icon: Icon(
                Icons.location_on_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final result =
                    await Navigator.pushNamed(context, SelectOnMap.routeName);

                if (result is LatLng) {
                  setState(() => pickedLocation = result);
                }
              },
              label: Text(
                'Select On Map',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              icon: Icon(
                Icons.map_rounded,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        )
      ],
    );
  }
}
