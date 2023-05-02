import 'package:appartement/pages/favoris.dart';
import 'package:appartement/pages/home.dart';
import 'package:appartement/pages/appartemnt/mes_appartement.dart';
import 'package:appartement/theme/color.dart';
import 'package:flutter/material.dart';
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