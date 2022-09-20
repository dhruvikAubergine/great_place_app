// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:great_place_app/features/add_place/pages/add_place_page.dart';
import 'package:great_place_app/features/add_place/services/location_service.dart';
import 'package:great_place_app/features/add_place/widgets/select_on_map.dart';
import 'package:great_place_app/features/home/pages/place_list_page.dart';
import 'package:great_place_app/features/home/providers/place_provider.dart';
import 'package:great_place_app/l10n/l10n.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    LocationService.instance.initailizeLocation();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 50, 224, 186),
    );
    return ChangeNotifierProvider.value(
      value: PlaceProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(color: colorScheme.primary),
          colorScheme: colorScheme,
          primaryColor: colorScheme.primary,
          // primaryColor: const Color.fromARGB(255, 50, 224, 186),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const PlaceListPage(),
        routes: {
          AddPlacePage.routeName: (context) => const AddPlacePage(),
          SelectOnMap.routeName: (context) => const SelectOnMap(),
        },
      ),
    );
  }
}
