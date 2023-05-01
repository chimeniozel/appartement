import 'package:flutter/material.dart';
import 'package:appartement/theme/color.dart';
import 'package:iconly/iconly.dart';

import '../model/Appartement.dart';

class FavorisItem extends StatelessWidget {
  const FavorisItem({Key? key, required this.appartement, required this.index})
      : super(key: key);
  final Appartement appartement;
  final int index;

  @override
  Widget build(BuildContext context) {
    return buildFavoris(context, index);
  }

  Widget buildFavoris(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      height: 130,
      decoration: BoxDecoration(
        color: appBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 15,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.height * 0.44,
              height: 104,
              margin: const EdgeInsets.only(right: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  index % 2 == 0
                      ? const SizedBox(
                          width: 150,
                        )
                      : Container(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 205,
                        height: 17,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              appartement.libele.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.place_outlined,
                              size: 13,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                                child: Text(
                              appartement.wilaya.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 205,
                        // color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${appartement.prix.toString()} MRU",
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            // const SizedBox(width: 110),
                            Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: const Icon(
                                  IconlyLight.heart,
                                  size: 20,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: index % 2 != 0 ? 10 : null,
            child: Container(
              height: 140,
              width: 150,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                  color: appBgColor,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(appartement.images!.first))),
            ),
          ),
        ],
      ),
    );
  }
}
