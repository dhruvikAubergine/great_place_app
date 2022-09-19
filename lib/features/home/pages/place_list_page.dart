import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_place_app/features/add_place/pages/add_place_page.dart';
import 'package:great_place_app/features/home/providers/place_provider.dart';
import 'package:provider/provider.dart';

class PlaceListPage extends StatelessWidget {
  const PlaceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Great Place App'),
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<PlaceProvider>(
                  builder: (context, places, child) => places.items.isEmpty
                      ? const Center(child: Text('no places'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: places.items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title: Text(places.items[index].title ?? ''),
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(places.items[index].image!),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AddPlacePage.routeName),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
