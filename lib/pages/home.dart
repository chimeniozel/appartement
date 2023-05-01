import 'package:appartement/model/Appartement.dart';
import 'package:appartement/pages/appartemnt/details_appartement.dart';
import 'package:appartement/pages/favoris.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../providers/input_provider.dart';
import '../theme/color.dart';
import '../widgets/input_widget.dart';
import '../widgets/property_card.dart';
import 'appartemnt/add_appartement.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();
  int selectedCategory = 0;
  String filter = "Pour Tout";

  bool forSell = false;

  String all = "all";
  @override
  Widget build(BuildContext context) {
    final inputProvider = Provider.of<InputProvider>(context);
    return Scaffold(
      // bottomNavigationBar: BottomBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Trouvez des maisons\n",
                        style: TextStyle(
                          fontSize: 22.0,
                          height: 1.3,
                          color: Color.fromRGBO(22, 27, 40, 70),
                        ),
                      ),
                      TextSpan(
                        text: "A Vendre & Louer",
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w800,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputWidget(
                          pass: false,
                          controller: search,
                          keyboardType: TextInputType.text,
                          height: 44.0,
                          hintText: "Rechercher",
                          prefixIcon: IconlyLight.search,
                          validator: (value) {
                            return null;
                          }),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    SizedBox(
                      height: 44,
                      child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              primaryColor,
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                            )),
                        onPressed: () {
                          setState(() {
                            selectedCategory = 0;
                            filter = "Pour Tout";
                            all = "all";
                          });
                          // Helper.nextScreen(context, Filters());
                        },
                        child: Row(
                          children: [
                            const Icon(
                              IconlyLight.more_square,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              filter,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            selectedCategory = 1;
                            // filter = "A Vendre";
                            forSell = true;
                            all = "";
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 52,
                          decoration: BoxDecoration(
                            color: selectedCategory == 1
                                ? primaryColor
                                : cardColor,
                            border: Border.all(
                              color: primaryColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "A Vendre",
                            style: TextStyle(
                              color: selectedCategory == 1
                                  ? cardColor
                                  : primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = 2;
                            // filter = "A Louer";
                            forSell = false;
                            all = "";
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 52,
                          decoration: BoxDecoration(
                            color: selectedCategory == 2
                                ? primaryColor
                                : cardColor,
                            border: Border.all(
                              color: primaryColor,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "A Louer",
                            style: TextStyle(
                              color: selectedCategory == 2
                                  ? cardColor
                                  : primaryColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Nouveaux appartements",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FavorisPage(),
                          ),
                        );
                      },
                      child: const Text("Voir tout",
                          style:
                              TextStyle(fontSize: 15.0, color: primaryColor)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),
                StreamBuilder<List<Appartement>>(
                    stream: Appartement().getAppartements(
                        forSell: forSell,
                        all: all,
                        uid: FirebaseAuth.instance.currentUser!.uid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 15.0,
                            );
                          },
                          itemCount: snapshot.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.data![index].libele
                                .toString()
                                .toLowerCase()
                                .contains(inputProvider.rechercher.text.toLowerCase())) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailsAppartement(
                                          appartement: snapshot.data![index]),
                                    ),
                                  );
                                },
                                child: PropertyCard(
                                  appartement: snapshot.data![index],
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 400,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height - 400,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/svg/no_data.svg",
                                  width: 200, height: 200, fit: BoxFit.cover),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Pas d'appartement disponible"),
                            ],
                          )),
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
