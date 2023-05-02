// ignore_for_file: use_build_context_synchronously

import 'package:appartement/widgets/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appartement/widgets/input_widget.dart';
import 'package:appartement/widgets/primary_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../pages/admin/appartements.dart';
import '../providers/input_provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isLoding = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final inputProvider = Provider.of<InputProvider>(context);

    login() async {
      try {
        setState(() {
          isLoding = true;
        });
        var user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: inputProvider.emailL.text,
                password: inputProvider.passL.text)
            .whenComplete(() => setState(() {
                  isLoding = false;
                }));
        if (user.user!.uid.isNotEmpty && user.user!.displayName != "admin") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomBar(),
              ));
        }
        else if(user.user!.uid.isNotEmpty && user.user!.displayName == "admin"){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AppartementsAdmin(),
              ));
        }
        return user;
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          showDialog(
              context: context,
              builder: (c) {
                return AlertDialog(
                  title: const Text("Message d'erreur"),
                  content: const Text("L'utilisateur est n'existe pas"),
                  actions: <Widget>[
                    PrimaryButton(
                      height: 20,
                      width: 20,
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
        } else if (e.code == "wrong-password") {
          showDialog(
              context: context,
              builder: (c) {
                return AlertDialog(
                  title: const Text("Message d'erreur"),
                  content: const Text("Email ou mot de passe est incorrect "),
                  actions: <Widget>[
                    PrimaryButton(
                        height: 35,
                        width: 60,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        widget: Text(
                          "Fermer",
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ))
                  ],
                );
              });
          setState(() {
            isLoding = false;
          });
        }
      } catch (e) {
        //
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
                controller: email,
                keyboardType: TextInputType.text,
                hintText: "Connexion par adresse e-mail",
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
                controller: pass,
                keyboardType: TextInputType.text,
                hintText: "Mot de passe",
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
              load: isLoding,
              height: 50,
              width: double.infinity,
              widget: isLoding
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text("Se connecter",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                    return;
                  }
                login();
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
                    height: 53.0,
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
