import 'dart:io';

import 'package:appartement/model/Appartement.dart';
import 'package:appartement/widgets/input_widget.dart';
// import 'package:cloud_firestore/cloud_firestore.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/input_provider.dart';
import '../theme/color.dart';
import '../widgets/primary_button.dart';

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

  final List<File> _image = [];
  List<String> imagesUrl = [];
  final picker = ImagePicker();
  int nbchamber = 0;
  int nbToilette = 0;
  var willayas = <String>["Nouakchott", "Nouadhibou", "Atar", "Nema"];
  String? value = "Nouakchott";
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    final inputProvider = Provider.of<InputProvider>(context);
    Future uploadFile(Appartement appartement) async {
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
            .whenComplete(() {
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
          // inputProvider.clearAddresse();
          // inputProvider.clearDiscription();
          // inputProvider.clearLibelle();
          // inputProvider.clearPrix();
          setState(() {
            _image.clear();
            nbchamber = 0;
            nbToilette = 0;
            value = willayas[0];
            uploading = false;
          });
        });
      }
    }

    return Scaffold(
      floatingActionButton: uploading
          ? Container()
          : PrimaryButton(
              widget: const Icon(
                IconlyLight.image,
                color: Colors.white,
              ),
              onPressed: () => !uploading ? chooseImage() : null,
              width: 50,
              height: 50),
      appBar: AppBar(
        title: const Text(
          "Ajouter un appartement",
          style: TextStyle(color: Colors.black),
        ),
        toolbarHeight: 60,
        backgroundColor: appBgColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 40,
              // ),
              // Container(
              //   margin: const EdgeInsets.only(right: 15, bottom: 15, top: 15),
              //   child: const Text(
              //     "Ajouter un appartement",
              //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              //   ),
              // ),
              InputWidget(
                pass: false,
                controller: libelle,
                keyboardType: TextInputType.text,
                hintText: "Libel appartement",
                prefixIcon: IconlyLight.home,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                pass: false,
                controller: discription,
                keyboardType: TextInputType.text,
                hintText: "Discreption",
                prefixIcon: IconlyLight.message,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                pass: false,
                controller: addresse,
                keyboardType: TextInputType.text,
                hintText: "Addresse",
                prefixIcon: IconlyLight.location,
              ),
              const SizedBox(
                height: 10,
              ),
              InputWidget(
                pass: false,
                controller: prix,
                keyboardType: TextInputType.number,
                hintText: "Prix",
                prefixIcon: Iconsax.dollar_circle,
              ),
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
                margin: const EdgeInsets.only(right: 15, bottom: 10, top: 20),
                child: const Text(
                  "Willayas",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                    setState(() {
                      // catVal = value;
                    });
                    print("Willayas est $value");
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
                                  // width: 100,
                                  // height: 100,
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
                  // load: uploading,
                  // text: "Ajouter",
                  onPressed: () {
                    if (_image.isNotEmpty) {
                      uploadFile(Appartement(
                          id: "appartement 1",
                          libele: inputProvider.libelle.text,
                          addresse: inputProvider.addresse.text,
                          description: inputProvider.discription.text,
                          images: imagesUrl,
                          location: const GeoPoint(18, -16),
                          nbChamber: nbchamber,
                          nbToilette: nbToilette,
                          propritaire: FirebaseAuth.instance.currentUser!.uid,
                          louePar: "",
                          prix: int.parse(inputProvider.prix.text),
                          status: "Libre",
                          wilaya: value));
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
    );
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) retrieveLostData();
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
      print(response.file);
    }
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }
}
