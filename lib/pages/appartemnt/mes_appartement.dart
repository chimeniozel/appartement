import 'package:appartement/model/Appartement.dart';
import 'package:appartement/pages/appartemnt/details_appartement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:unicons/unicons.dart';
import '../../theme/color.dart';
import '../auth/authentication.dart';

class MesAppartements extends StatefulWidget {
  const MesAppartements({super.key});

  @override
  State<MesAppartements> createState() => _MesAppartementsState();
}

class _MesAppartementsState extends State<MesAppartements> {
  var endDate = DateTime.now();

  var startDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes appartemnts",
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 60,
        backgroundColor: appBgColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance
                    .signOut()
                    .whenComplete(() => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Authentication(),
                        )));
              },
              icon: const Icon(
                IconlyLight.logout,
                color: primaryColor,
              ))
        ],
      ),
      body: StreamBuilder<List<Appartement>>(
          stream: Appartement()
              .getMesAppartement(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Appartement appartement = snapshot.data![index];
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsAppartement(appartement: appartement),
                          )),
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                offset: const Offset(4, 4),
                                blurRadius: 10,
                                color: const Color(0xffb8bfce).withOpacity(.2),
                              ),
                              BoxShadow(
                                offset: const Offset(-3, 0),
                                blurRadius: 15,
                                color: const Color(0xffb8bfce).withOpacity(.1),
                              )
                            ],
                          ),
                          child: Slidable(
                            key: UniqueKey(),
                            endActionPane: ActionPane(
                                dismissible: DismissiblePane(onDismissed: () {
                                  FirebaseFirestore.instance
                                      .collection("appartements")
                                      .doc(appartement.id)
                                      .delete();
                                }),
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      icon: UniconsLine.trash_alt,
                                      label: "Supprimer",
                                      backgroundColor:
                                      Colors.red.withOpacity(0.9),
                                      onPressed: (context) async {
                                        await FirebaseFirestore.instance
                                            .collection("appartements")
                                            .doc(appartement.id)
                                            .delete();
                                      })
                                ]),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                leading: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(13)),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      // color: randomColor(),
                                    ),
                                    child: FadeInImage(
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                        appartement.images!.first,
                                      ),
                                      placeholder: const AssetImage(
                                          "assets/images/appartement2.png"),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  appartement.libele.toString(),
                                ),
                                subtitle: Text(
                                  appartement.description.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Container(
                                    width: 65,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: appartement.confirmation !=
                                            "acceptee"
                                            ? appartement.confirmation ==
                                            "refusee"
                                            ? red
                                            : secondary
                                            : primaryColor,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                          appartement.confirmation.toString(),
                                          style: const TextStyle(color: Colors.white),
                                        ))),
                              ),
                            ),
                          )),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/svg/add.svg",
                            width: 200, height: 200, fit: BoxFit.cover),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            "Vous n'avez pas ajouté d'appartement, ajoutez-en un"),
                      ],
                    )),
              );
            }
          })
      );
  }
}
