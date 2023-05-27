import 'package:appartement/pages/favoris.dart';
import 'package:appartement/pages/home.dart';
import 'package:appartement/pages/appartemnt/mes_appartement.dart';
import 'package:appartement/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../pages/appartemnt/add_appartement.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  var tabs = <Widget>[
    const Home(),
    const FavorisPage(),
    const AddAppartement(),
    const MesAppartements(),
  ];
  int index = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      index = i;
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[index],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: index,
        onTap: _handleIndexChanged,
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(IconlyLight.home),
            title: const Text("Accueil"),
            selectedColor: primaryColor,
          ),

          /// Favoris
          SalomonBottomBarItem(
            icon: const Icon(IconlyLight.heart),
            title: const Text("Favoris"),
            selectedColor: primaryColor,
          ),

          /// Ajouter
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.add),
            title: const Text("Ajouter"),
            selectedColor: primaryColor,
          ),

          /// Mes Appartements
          SalomonBottomBarItem(
            icon: const Icon(Iconsax.activity),
            title: const Text("Mes Appartements"),
            selectedColor: primaryColor,
          ),
        ],
      ),
    );
  }
}