import 'package:appartement/model/Appartement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
// import 'package:real_estate_ui/models/appartement.dart';

import '../theme/color.dart';

class PropertyCard extends StatelessWidget {
  final Appartement appartement;
  PropertyCard({required this.appartement});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      margin: const EdgeInsets.only(bottom: 5),
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
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        appartement.images!.first,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !appartement.favorisUID!.contains(
                                FirebaseAuth.instance.currentUser!.uid)
                            ? Colors.white
                            : Colors.red,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          List<String> favorisUID = appartement.favorisUID!;
                          if (!appartement.favorisUID!.contains(
                              FirebaseAuth.instance.currentUser!.uid)) {
                            favorisUID
                                .add(FirebaseAuth.instance.currentUser!.uid);
                            await FirebaseFirestore.instance
                                .collection("appartements")
                                .doc(appartement.id)
                                .update({"favorisUID": favorisUID});
                          } else {
                            favorisUID.remove(FirebaseAuth.instance.currentUser!.uid);
                            await FirebaseFirestore.instance
                                .collection("appartements")
                                .doc(appartement.id)
                                .update({"favorisUID": favorisUID});
                          }
                        },
                        icon: const Icon(IconlyLight.heart),
                        color: !appartement.favorisUID!.contains(
                                FirebaseAuth.instance.currentUser!.uid)
                            ? primaryColor
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15.0,
                  left: 10.0,
                  child: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            //  this.appartement.appartementTypes == appartementTypes.AGENCY
                            //     ?
                            primaryColor
                        // : Color.fromRGBO(255, 136, 0, 1),
                        ),
                    child: const Center(
                      child: Text(
                        // this.appartement.appartementTypes == appartementTypes.AGENCY
                        //     ?
                        "Utilisateur"
                        // : "Private",
                        ,
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        appartement.libele.toString(),
                        style: const TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                    Text(
                      "${appartement.prix.toString()} MRU",
                      style: const TextStyle(
                        fontSize: 17.0,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  appartement.description.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Color(0xFF343434),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    const Icon(
                      IconlyLight.location,
                      size: 15.0,
                      color: Color.fromRGBO(255, 136, 0, 1),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      appartement.addresse.toString(),
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Color(0xFF343434),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
