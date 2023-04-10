import 'package:appartement/model/Appartement.dart';
import 'package:appartement/theme/color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unicons/unicons.dart';

class DetailsAppartement extends StatefulWidget {
  final Appartement appartement;
  const DetailsAppartement({super.key, required this.appartement});

  @override
  State<DetailsAppartement> createState() => _DetailsAppartementState();
}

class _DetailsAppartementState extends State<DetailsAppartement> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: SingleChildScrollView(
          child: Column(
              // height: 1100,
              // width: double.infinity,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CarouselSlider.builder(
                      itemCount: widget.appartement.images!.length,
                      // items: List.generate(widget.appartement.images!.length,
                      //     (index) => Image.network(widget.appartement.images![index],fit: BoxFit.cover,)),
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
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          // do something with the index of the current page
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
                      // right: 150,
                      child: buildIndicator(activeIndex, widget.appartement),
                    ),
                    Positioned(
                        top: 350,
                        right: 30,
                        child: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                                color: primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ))),
                    // )
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
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color:
                                        Colors.blue.shade100.withOpacity(0.3),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            // color: Colors.blue.shade100,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: const Icon(
                                          UniconsLine.bath,
                                          color: primaryColor,
                                        )),
                                    Text(widget.appartement.nbToilette
                                        .toString())
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
                                    color:
                                        Colors.blue.shade100.withOpacity(0.3),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            // color: Colors.blue.shade100,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: const Icon(
                                          Icons.bed_rounded,
                                          color: primaryColor,
                                        )),
                                    Text(
                                        widget.appartement.nbChamber.toString())
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
                                    color:
                                        Colors.blue.shade100.withOpacity(0.3),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            // color: Colors.blue.shade100,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: const Icon(
                                          Icons.food_bank_rounded,
                                          color: primaryColor,
                                        )),
                                    const Text("1")
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
                                    color:
                                        Colors.blue.shade100.withOpacity(0.3),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 35,
                                        width: 35,
                                        decoration: const BoxDecoration(
                                            // color: Colors.blue.shade100,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        child: const Icon(
                                          Icons.room_preferences_rounded,
                                          color: primaryColor,
                                        )),
                                    const Text("3")
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
                      Container(
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://images.unsplash.com/photo-1549517045-bc93de075e53?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"))),
                                ),
                                title: const Text(
                                  "Nom utilisateur",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: const Text(
                                  "Sous-titre",
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shadowColor:
                                                Colors.black.withOpacity(1),
                                            foregroundColor: primary,
                                            minimumSize:
                                                const Size.fromHeight(60),
                                            backgroundColor: appBgColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            elevation: 1.5,
                                          ),
                                          onPressed: () {},
                                          child: const Text(
                                            "Envoyer un message",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                const Size.fromHeight(60),
                                            backgroundColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            elevation: 1.5,
                                          ),
                                          onPressed: () async {
                                            final Uri launchUri = Uri(
                                              scheme: 'tel',
                                              path: "+22220495770",
                                            );
                                            // await launchUrl(launchUri);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(IconlyLight.call),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text("Appel"),
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
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
    // margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)
        //     image: DecorationImage(
        //         fit: BoxFit.cover,
        //         image: NetworkImage(appartement.images![index]))
        ),
    child: FadeInImage(
      image: NetworkImage(appartement.images![index]),
      placeholderFit: BoxFit.cover,
      fit: BoxFit.cover,
      placeholder: const AssetImage(
        "assets/images/appartement2.png",
      ),
      // child: Image.network(
      //   appartement.images![index],
      //   fit: BoxFit.cover,
      // ),
    ),
  );
}
