import 'package:appartement/providers/input_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appartement/widgets/input_widget.dart';
import 'package:appartement/widgets/primary_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isLoding = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final inputProvider = Provider.of<InputProvider>(context);

    addUser() async {
      setState(() {
        isLoding = true;
      });
      CollectionReference userRef =
          FirebaseFirestore.instance.collection("users");
      try {
        var user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: inputProvider.emailR.text,
            password: inputProvider.passR.text);
        user.user!.updateDisplayName(inputProvider.nomPrenom.text);
        userRef.doc(user.user!.uid).set({
          "id": user.user!.uid,
          "nom": inputProvider.nomPrenom.text,
          "email": inputProvider.emailR.text,
          "telephone": inputProvider.telephone.text,
        }).whenComplete(() {
          setState(() {
            isLoding = false;
          });
          // inputProvider.clearNomPrenom();
          // inputProvider.clearTelephone();
          // inputProvider.clearEmailL();
          // inputProvider.clearPassR();
          showDialog(
              context: context,
              builder: (c) {
                return AlertDialog(
                  title: const Text("Message succsess"),
                  content: const Text("L'utilisateur est bien ajouter !"),
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
        });
        return user;
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          print("le mot de passe est faible ");
          showDialog(
              context: context,
              builder: (c) {
                return AlertDialog(
                  title: const Text("Message d'erreur"),
                  content: const Text("le mot de passe est faible "),
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
            isLoding = false;
          });
        } else if (e.code == "email-already-in-use") {
          print("email deja existe ");
          showDialog(
              context: context,
              builder: (c) {
                return AlertDialog(
                  title: const Text("Message d'erreur"),
                  content: const Text("email est deja utilisee !"),
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
            isLoding = false;
          });
        }
      } catch (e) {
        print(e);
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputWidget(
                pass: false,
                controller: inputProvider.nomPrenom,
                keyboardType: TextInputType.text,
                hintText: "Nom et prenom",
                prefixIcon: IconlyLight.user,
                validator: (value) {
                  if (value!.isNotEmpty && value.length > 2) {
                    return null;
                  } else if (value.isEmpty) {
                    return "Entrez votre Nom et prenom";
                  }
                }),
            const SizedBox(height: 15.0),
            const SizedBox(height: 15.0),
            InputWidget(
                pass: false,
                controller: inputProvider.telephone,
                keyboardType: TextInputType.text,
                hintText: "Telephone",
                prefixIcon: IconlyLight.call,
                validator: (value) {
                  if (value!.isNotEmpty && value.length >= 8) {
                    return null;
                  } else if (value.length < 8 && value.isNotEmpty) {
                    return "Votre Numero Telephone est Incorrect";
                  } else {
                    return "Entrez Votre Numero Telephone";
                  }
                }),
            const SizedBox(height: 15.0),
            InputWidget(
                pass: false,
                controller: inputProvider.emailR,
                keyboardType: TextInputType.text,
                hintText: "Adresse e-mail",
                prefixIcon: IconlyLight.message,
                validator: (value) {
                  if (value!.isNotEmpty && value.length >= 10) {
                    return null;
                  } else if (value.length < 10 && value.isNotEmpty) {
                    return "Votre Email est Incorrect";
                  } else {
                    return "Entrez Votre Email";
                  }
                }),
            const SizedBox(height: 15.0),
            InputWidget(
                pass: true,
                controller: inputProvider.passR,
                keyboardType: TextInputType.text,
                hintText: "S'inscrire mot de passe",
                prefixIcon: IconlyLight.lock,
                validator: (value) {
                  if (value!.isNotEmpty && value.length > 5) {
                    return null;
                  } else if (value.length < 8 && value.isNotEmpty) {
                    return "Le mot de passe est faible";
                  } else {
                    return "Merci de nous donner votre mot de passe";
                  }
                }),
            const SizedBox(height: 25.0),
            PrimaryButton(
              height: 50,
              width: double.infinity,
              widget: isLoding
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text("Enregistrez-vous",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                addUser();
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              children: const <Widget>[
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "OU",
                    style: TextStyle(),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    height: 53,
                    width: 150.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/google.svg",
                          width: 30.0,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          "Google",
                          style: TextStyle(
                            color: Color.fromRGBO(105, 108, 121, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    height: 53,
                    width: 150.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/facebook.svg",
                          width: 30.0,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          "Facebook",
                          style: TextStyle(
                            color: Color.fromRGBO(105, 108, 121, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
