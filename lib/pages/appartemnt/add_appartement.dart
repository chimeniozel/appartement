// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:appartement/model/Appartement.dart';
import 'package:appartement/widgets/input_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/input_provider.dart';
import '../../theme/color.dart';
import '../../widgets/primary_button.dart';
import 'package:geolocator/geolocator.dart';

class AddAppartement extends StatefulWidget {
  const AddAppartement({super.key});

  @override
  State<AddAppartement> createState() => _AddAppartementState();
}

class _AddAppartementState extends State<AddAppartement> {
  TextEditingController libelle = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController addresse = TextEditingController();
  TextEditingController prix = TextEditingController();
  bool uploading = false;
  double val = 0;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  int selectedCategory = 2;
  final List<File> _image = [];
  List<String> imagesUrl = [];
  final picker = ImagePicker();
  int nbchamber = 0;
  int nbCuisines = 0;
  int nbToilette = 0;
  var willayas = <String>["Nouakchott", "Nouadhibou", "Atar", "Nema"];
  String? value = "Nouakchott";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double? lat , long;
  bool forSell = false;
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );
  location() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
    // print("lat : $lat , long : $long");
  }

  @override
  Widget build(BuildContext context) {
    final inputProvider = Provider.of<InputProvider>(context);
    Future uploadFile(Appartement appartement) async {
      // print("test ================ ");
      setState(() {
        uploading = true;
      });
      int i = 1;
      for (var img in _image) {
        setState(() {
          val = i / _image.length;
        });
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('images/${img.path}');
        await ref.putFile(img).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            imagesUrl.add(value);
            i++;
          });
        });
      }
      if (imagesUrl.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection("appartements")
            .add(appartement.toMap())
            .then((appart) async {
          await FirebaseFirestore.instance
              .collection("appartements")
              .doc(appart.id)
              .update({"id": appart.id});
          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (c) {
                return AlertDialog(
                  title: const Text("Message succsess"),
                  content: const Text("L'appartement est bien ajouter !"),
                  actions: <Widget>[
                    PrimaryButton(
                      height: 35,
                      width: 60,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      widget: Text("Fermer",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                    )
                  ],
                );
              });

          setState(() {
            _image.clear();
            imagesUrl.clear();
            nbchamber = 0;
            nbToilette = 0;
            nbCuisines = 0;
            value = willayas[0];
            uploading = false;
          });
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ajouter un appartement",
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 60,
        backgroundColor: appBgColor,
        elevation: 0,
        actions: [
          uploading
          ? Container()
          : Container(
            margin: const EdgeInsets.all(10),
            child: PrimaryButton(
                widget: const Icon(
                  IconlyLight.image,
                  color: Colors.white,
                ),
                onPressed: () => !uploading ? chooseImage() : null,
                width: 40,
                height: 40),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputWidget(
                  pass: false,
                  controller: libelle,
                  keyboardType: TextInputType.text,
                  hintText: "Libel appartement",
                  prefixIcon: IconlyLight.home,
                  validator: (value) {
                    if (value!.isNotEmpty && value.length > 2) {
                      return null;
                    } else if (value.isEmpty) {
                      return "Entrez Le Nom Du produit";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                InputWidget(
                    pass: false,
                    controller: discription,
                    keyboardType: TextInputType.text,
                    hintText: "Discreption",
                    prefixIcon: IconlyLight.info_circle,
                    validator: (value) {
                      if (value!.isNotEmpty && value.length >= 2) {
                        return null;
                      } else if (value.isEmpty || value.length < 5) {
                        return "La Description Est Faible";
                      } else {
                        return "Entrez une Description";
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                InputWidget(
                    pass: false,
                    controller: addresse,
                    keyboardType: TextInputType.text,
                    hintText: "Addresse",
                    prefixIcon: IconlyLight.location,
                    validator: (value) {
                      if (value!.isNotEmpty && value.length >= 2) {
                        return null;
                      } else if (value.isEmpty) {
                        return "L'Addresse Est Faible";
                      } else {
                        return "Entrez une Addresse";
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                InputWidget(
                    pass: false,
                    controller: prix,
                    keyboardType: TextInputType.number,
                    hintText: "Prix",
                    prefixIcon: Iconsax.dollar_circle,
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else if (value.isEmpty) {
                        return "Entrez La Prix";
                      }
                      return null;
                    }),
                Container(
                  margin: const EdgeInsets.only(right: 15, bottom: 15, top: 15),
                  child: const Text(
                    "Nombre des chambres",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PrimaryButton(
                      height: 25,
                      width: 40,
                      widget: Text("-",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        if (nbchamber != 0) {
                          setState(() {
                            nbchamber--;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("$nbchamber"),
                    const SizedBox(
                      width: 5,
                    ),
                    PrimaryButton(
                      height: 25,
                      width: 40,
                      widget: Text("+",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        setState(() {
                          nbchamber++;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 15, bottom: 15, top: 15),
                  child: const Text(
                    "Nombre des toilettes",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PrimaryButton(
                      height: 25,
                      width: 40,
                      widget: Text("-",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        if (nbToilette != 0) {
                          setState(() {
                            nbToilette--;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("$nbToilette"),
                    const SizedBox(
                      width: 5,
                    ),
                    PrimaryButton(
                      height: 25,
                      width: 40,
                      widget: Text("+",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        setState(() {
                          nbToilette++;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 15, bottom: 15, top: 15),
                  child: const Text(
                    "Nombre des Cuisines",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PrimaryButton(
                      height: 25,
                      width: 40,
                      widget: Text("-",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        if (nbCuisines != 0) {
                          setState(() {
                            nbCuisines--;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("$nbCuisines"),
                    const SizedBox(
                      width: 5,
                    ),
                    PrimaryButton(
                      height: 25,
                      width: 40,
                      widget: Text("+",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      onPressed: () {
                        setState(() {
                          nbCuisines++;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 15, bottom: 10, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Willayas",
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                selectedCategory = 1;
                                forSell = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              height: 40,
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
                          const SizedBox(
                            width: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = 2;
                                forSell = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              height: 40,
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
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          ),
                        )),
                    hint: const Text(
                      "Willayas",
                      style: TextStyle(fontSize: 13),
                    ),
                    onChanged: (value) => setState(() {
                      this.value = value;
                    }),
                    value: value,
                    items: willayas.map((buildMenuItem)).toList(),
                  ),
                ),
                _image.isNotEmpty
                    ? Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 200,
                            width: double.infinity,
                            child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _image.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: FileImage(_image[index]),
                                            fit: BoxFit.cover)),
                                  );
                                }),
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                    widget: uploading
                        ? CircularProgressIndicator(
                            value: val,
                            color: Colors.white,
                          )
                        : Text("Ajouter",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                      return;
                    }
                      if (_image.isNotEmpty) {
                        uploadFile(Appartement(
                            libele: inputProvider.libelle.text,
                            addresse: inputProvider.addresse.text,
                            description: inputProvider.discription.text,
                            images: imagesUrl,
                            favorisUID: <String>[],
                            location: const GeoPoint(18.0887773, -15.9661104),
                            nbChamber: nbchamber,
                            nbCuisines: nbCuisines,
                            nbToilette: nbToilette,
                            propritaire: FirebaseAuth.instance.currentUser!.uid,
                            dateCreation: Timestamp.now(),
                            prix: int.parse(inputProvider.prix.text),
                            status: "Libre",
                            wilaya: value,
                            confirmation: "nouveau",
                            forSell: forSell));
                      } else {
                        showDialog(
                            context: context,
                            builder: (c) {
                              return AlertDialog(
                                title: const Text("Message succsess"),
                                content: const Text("Quelque chose ne va pas !"),
                                actions: <Widget>[
                                  PrimaryButton(
                                    height: 35,
                                    width: 60,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    widget: Text("Fermer",
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        )),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    width: double.infinity,
                    height: 50),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path.isNotEmpty) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
    }
  }

  @override
  void initState() {
    super.initState();
    location();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }
}
