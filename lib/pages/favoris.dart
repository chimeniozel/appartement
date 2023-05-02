import 'package:appartement/model/Appartement.dart';
import 'package:appartement/pages/appartemnt/details_appartement.dart';
import 'package:appartement/theme/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/favoris_item.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({super.key});

  @override
  State<FavorisPage> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Mes favoris",
            style: TextStyle(color: Colors.black),
          ),
          toolbarHeight: 60,
          backgroundColor: appBgColor,
          elevation: 0,
        ),
        body: getBody());
  }

  listFavoris() {
    return StreamBuilder<List<Appartement>>(
        stream: Appartement().getFavoris(FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return SizedBox(
              width: double.infinity,
              height: 720,
              child: ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsAppartement(
                                  appartement: snapshot.data![index]),
                            )),
                        child: FavorisItem(
                            appartement: snapshot.data![index], index: index),
                      ),
                  itemCount: snapshot.data!.length),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/hooked.svg",
                      width: 200, height: 200, fit: BoxFit.cover),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Pas d'appartement favorisee"),
                ],
              )),
            );
          }
        });
  }

  getBody() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listFavoris(),
      ],
    ));
  }
}
