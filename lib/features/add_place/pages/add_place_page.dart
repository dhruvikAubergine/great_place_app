import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_place_app/features/add_place/widgets/location_input.dart';
import 'package:great_place_app/features/home/providers/place_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
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

        final appDir = await getApplicationDocumentsDirectory();
        final fileName = path.basename(imageFile.path);
        final savedImage = await tempImage.copy('${appDir.path}/$fileName');
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

    Provider.of<PlaceProvider>(context, listen: false)
        .addPlace(_titleController.text, _storedFile!);
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
                          label: Text(
                            'Choose Image',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const LocationInput()
                  ],
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
