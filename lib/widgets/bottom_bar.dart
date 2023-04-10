import 'package:appartement/pages/explore.dart';
import 'package:appartement/pages/favoris.dart';
import 'package:appartement/pages/home.dart';
import 'package:appartement/pages/settings.dart';
import 'package:appartement/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../pages/add_appartement.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var Tabs = <Widget>[
    const Home(),
    const FavorisPage(),
    const AddAppartement(),
    const Settings(),
  ];
  var _selectedTab = _SelectedTab.home;
  
  int index = 0;

  void _handleIndexChanged(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tabs[index],
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
    
          /// Likes
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
    
          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(IconlyLight.profile),
            title: const Text("Profil"),
            selectedColor: primaryColor,
          ),
        ],
      ),
    );
  }
}

enum _SelectedTab { home, likes, search, profile }
