import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:great_place_app/features/add_place/services/location_service.dart';
import 'package:great_place_app/features/add_place/widgets/select_on_map.dart';
import 'package:great_place_app/features/home/providers/place_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({super.key});

  static const routeName = '/add-place';

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  File? _storedFile;
  LatLng? pickedLocation;

  Future<void> pickImage() async {
    try {
      final imageFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (imageFile != null) {
        final tempImage = File(imageFile.path);

        setState(() {
          _storedFile = tempImage;
        });
        log(_storedFile?.path ?? 'no file piked');

        // final appDir = await getApplicationDocumentsDirectory();
        // final fileName = path.basename(imageFile.path);
        // final savedImage = await tempImage.copy('${appDir.path}/$fileName');
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image is not selected')),
        );
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'Image Picker');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image is not selected')),
      );
    }
  }

  void _onSave() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    _formKey.currentState?.save();
    if (_storedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select image.')),
      );
      return;
    }
    if (pickedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select location.')),
      );
      return;
    }

    Provider.of<PlaceProvider>(context, listen: false).addPlace(
      _titleController.text,
      _storedFile!,
      pickedLocation!.latitude,
      pickedLocation!.longitude,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Place'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _titleController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          final title = value?.trim() ?? '';
                          if (title.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: _storedFile != null
                                ? Image.file(
                                    _storedFile!,
                                    fit: BoxFit.cover,
                                  )
                                : const Center(child: Text('No Image Taken')),
                          ),
                          TextButton.icon(
                            onPressed: pickImage,
                            icon: Icon(
                              Icons.photo_camera,
                              color: Theme.of(context).primaryColor,
                            ),
                            label: const Text(
                              'Choose Image',
                              style: TextStyle(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
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
                                    () => pickedLocation = LocationService
                                        .instance.currentLocation,
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
                                  final result = await Navigator.pushNamed(
                                    context,
                                    SelectOnMap.routeName,
                                  );

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
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _onSave,
                style: const ButtonStyle(),
                child: Text(
                  'Add Place',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
