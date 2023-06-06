// ignore_for_file: file_names, deprecated_member_use

import 'package:appartement/model/Appartement.dart';
import 'package:appartement/theme/color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../model/Users.dart';

class DetailsAppartementAdmin extends StatefulWidget {
  final Appartement appartement;
  const DetailsAppartementAdmin({super.key, required this.appartement});

  @override
  State<DetailsAppartementAdmin> createState() =>
      _DetailsAppartementAdminState();
}

class _DetailsAppartementAdminState extends State<DetailsAppartementAdmin> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CarouselSlider.builder(
                  itemCount: widget.appartement.images!.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = widget.appartement.images![index];
                    return buildImage(
                      urlImage,
                      index,
                      widget.appartement,
                    );
                  },
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.99,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 10),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Positioned(
                  top: 380,
                  left: 200,
                  child: buildIndicator(activeIndex, widget.appartement),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 5,
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.appartement.libele.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.place_outlined,
                                color: darker,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.appartement.addresse.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    var url =
                                        "https://www.google.com/maps/@${widget.appartement.location!.latitude},${widget.appartement.location!.longitude},14z";
                                    await launch(url);
                                  },
                                  child: const Text(
                                    "Voir Sur Maps",
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 15),
                                  ))
                            ],
                          )
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: Text(
                            "${widget.appartement.prix.toString()} MRU",
                            style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade100.withOpacity(0.3),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: const Icon(
                                      UniconsLine.bath,
                                      color: primaryColor,
                                    )),
                                Text(widget.appartement.nbToilette.toString())
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade100.withOpacity(0.3),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: const Icon(
                                      Icons.bed_rounded,
                                      color: primaryColor,
                                    )),
                                Text(widget.appartement.nbChamber.toString())
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade100.withOpacity(0.3),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 35,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: const Icon(
                                      Icons.food_bank_rounded,
                                      color: primaryColor,
                                    )),
                                Text(widget.appartement.nbCuisines.toString())
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Discreption",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.appartement.description.toString(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold),
                  ),
                  StreamBuilder<Users>(
                      stream: Users()
                          .getUser(widget.appartement.propritaire.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Users? user = snapshot.data;
                          return Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  top: 30, right: 10, bottom: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(2, 2),
                                      spreadRadius: 5,
                                      blurRadius: 25,
                                    ),
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/user.jpg"))),
                                    ),
                                    title: Text(
                                      user!.nom.toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      user.email.toString(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    trailing: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size(50,30),
                                          backgroundColor: darker,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 1.5,
                                        ),
                                        onPressed: () async {
                                          final Uri launchUri = Uri(
                                            scheme: 'tel',
                                            path: "+222${user.telephone}",
                                          );
                                          await launchUrl(launchUri);
                                        },
                                        child: const Icon(IconlyLight.call)),
                                  ),
                                  StreamBuilder<dynamic>(
                                      stream: Appartement().getUIConfirmation(
                                          widget.appartement.id.toString()),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          var confirmation = snapshot.data;
                                          return Container(
                                            height: 60,
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: confirmation == "nouveau"
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        flex: 4,
                                                        child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              shadowColor: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      1),
                                                              foregroundColor:
                                                                  primary,
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(60),
                                                              backgroundColor:
                                                                  primaryColor,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              elevation: 1.5,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              // var url =
                                                              //     'https://wa.me/${user.telephone}';
                                                              // await launch(url);
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "appartements")
                                                                  .doc(widget
                                                                      .appartement
                                                                      .id)
                                                                  .update({
                                                                "confirmation":
                                                                    "acceptee"
                                                              });
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: const [
                                                                Text(
                                                                  "Confirmer",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Icon(
                                                                    FontAwesomeIcons
                                                                        .check,
                                                                    color: Colors
                                                                        .white)
                                                              ],
                                                            )),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(60),
                                                              backgroundColor:
                                                                  red,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              elevation: 1.5,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              // final Uri launchUri = Uri(
                                                              //   scheme: 'tel',
                                                              //   path: "+222${user.telephone}",
                                                              // );
                                                              // await launchUrl(launchUri);
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "appartements")
                                                                  .doc(widget
                                                                      .appartement
                                                                      .id)
                                                                  .update({
                                                                "confirmation":
                                                                    "refusee"
                                                              });
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: const [
                                                                Text("Refuser"),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .remove,
                                                                ),
                                                              ],
                                                            )),
                                                      )
                                                    ],
                                                  )
                                                : confirmation == "acceptee"
                                                    ? ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          minimumSize: const Size
                                                              .fromHeight(60),
                                                          backgroundColor: red,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          elevation: 1.5,
                                                        ),
                                                        onPressed: () async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "appartements")
                                                              .doc(widget
                                                                  .appartement
                                                                  .id)
                                                              .update({
                                                            "confirmation":
                                                                "refusee"
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: const [
                                                            Text("Refuser"),
                                                            // SizedBox(
                                                            //   width: 3,
                                                            // ),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .remove,
                                                            ),
                                                          ],
                                                        ))
                                                    : ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shadowColor: Colors
                                                              .black
                                                              .withOpacity(1),
                                                          foregroundColor:
                                                              primary,
                                                          minimumSize: const Size
                                                              .fromHeight(60),
                                                          backgroundColor:
                                                              primaryColor,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          elevation: 1.5,
                                                        ),
                                                        onPressed: () async {
                                                          // var url =
                                                          //     'https://wa.me/${user.telephone}';
                                                          // await launch(url);
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "appartements")
                                                              .doc(widget
                                                                  .appartement
                                                                  .id)
                                                              .update({
                                                            "confirmation":
                                                                "acceptee"
                                                          });
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: const [
                                                            Text(
                                                              "Confirmer",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Icon(
                                                                FontAwesomeIcons
                                                                    .check,
                                                                color: Colors
                                                                    .white)
                                                          ],
                                                        )),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      })
                                ],
                              ));
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            )
          ]),
        ));
  }
}

buildIndicator(int activeIndex, Appartement appartement) {
  return AnimatedSmoothIndicator(
      effect: const ScrollingDotsEffect(dotWidth: 7, dotHeight: 7),
      activeIndex: activeIndex,
      count: appartement.images!.length);
}

Widget buildImage(String urlImage, int index, Appartement appartement) {
  return Container(
    height: 400,
    width: double.infinity,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    child: FadeInImage(
      image: NetworkImage(appartement.images![index]),
      placeholderFit: BoxFit.cover,
      fit: BoxFit.cover,
      placeholder: const AssetImage(
        "assets/images/sekeni.png",
      ),
    ),
  );
}
