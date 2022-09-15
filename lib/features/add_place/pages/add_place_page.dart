import 'package:flutter/material.dart';

class AddPlacePage extends StatelessWidget {
  const AddPlacePage({super.key});

  static const routeName = '/add-place';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Place'),
        
      ),
    );
  }
}
