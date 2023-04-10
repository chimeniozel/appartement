import 'package:appartement/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/input_provider.dart';

class InputWidget extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final double height;
  final bool pass;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const InputWidget(
      {super.key,
      required this.hintText,
      required this.prefixIcon,
      this.height = 53.0,
      required this.keyboardType,
      required this.controller,
      required this.pass});

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    final inputProvider = Provider.of<InputProvider>(context);
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.only(
        right: 16.0,
        left: widget.prefixIcon == null ? 16.0 : 0.0,
      ),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: widget.pass,
        onChanged: (value) {
          setState(() {
            widget.controller.text = value;
            if (widget.hintText == "Nom et prenom") {
              inputProvider.setNomPrenom(widget.controller);
            }
            if (widget.hintText == "Telephone") {
              inputProvider.setTelephone(widget.controller);
            }
            if (widget.hintText == "Adresse e-mail") {
              inputProvider.setEmailR(widget.controller);
            }
            if (widget.hintText == "S'inscrire mot de passe") {
              inputProvider.setPassR(widget.controller);
            }
            if (widget.hintText == "Connexion par adresse e-mail") {
              inputProvider.setEmailL(widget.controller);
            }
            if (widget.hintText == "Mot de passe") {
              inputProvider.setPassL(widget.controller);
            }
            if (widget.hintText == "Libel appartement") {
              inputProvider.setLibelle(widget.controller);
            }
            if (widget.hintText == "Discreption") {
              inputProvider.setDiscription(widget.controller);
            }
            if (widget.hintText == "Addresse") {
              inputProvider.setAddresse(widget.controller);
            }
            if (widget.hintText == "Prix") {
              inputProvider.setPrix(widget.controller);
            }
            if (widget.hintText == "Rechercher") {
              inputProvider.setRechercher(widget.controller);
            }
            
          });
        },
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon == null
              ? null
              : Icon(
                  widget.prefixIcon,
                  color: primaryColor,
                ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(105, 108, 121, 1),
          ),
        ),
      ),
    );
  }
}
