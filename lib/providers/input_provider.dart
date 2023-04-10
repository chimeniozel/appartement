import 'package:flutter/material.dart';

class InputProvider extends ChangeNotifier {
  TextEditingController emailR = TextEditingController();
  TextEditingController passR = TextEditingController();
  TextEditingController emailL = TextEditingController();
  TextEditingController passL = TextEditingController();
  TextEditingController nomPrenom = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController rechercher = TextEditingController();

  TextEditingController libelle = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController addresse = TextEditingController();
  TextEditingController prix = TextEditingController();

  void setEmailR(TextEditingController controller) {
    emailR = controller;
    notifyListeners();
  }

  void clearEmailR() {
    emailR.clear();
    notifyListeners();
  }
  void setLibelle(TextEditingController controller) {
    libelle = controller;
    notifyListeners();
  }

  void clearLibelle() {
    libelle.clear();
    notifyListeners();
  }

  void setPrix(TextEditingController controller) {
    prix = controller;
    notifyListeners();
  }

  void clearPrix() {
    prix.clear();
    notifyListeners();
  }

  void setAddresse(TextEditingController controller) {
    addresse = controller;
    notifyListeners();
  }

  void clearAddresse() {
    addresse.clear();
    notifyListeners();
  }

  void setDiscription(TextEditingController controller) {
    discription = controller;
    notifyListeners();
  }

  void clearDiscription() {
    discription.clear();
    notifyListeners();
  }

  void setPassR(TextEditingController controller) {
    passR = controller;
    notifyListeners();
  }

  void clearPassR() {
    passR.clear();
    notifyListeners();
  }

  void setEmailL(TextEditingController controller) {
    emailL = controller;
    notifyListeners();
  }

  void clearEmailL() {
    emailL.clear();
    notifyListeners();
  }

  void setPassL(TextEditingController controller) {
    passL = controller;
    notifyListeners();
  }

  void clearPassL() {
    passL.clear();
    notifyListeners();
  }

  void setNomPrenom(TextEditingController controller) {
    nomPrenom = controller;
    notifyListeners();
  }

  void clearNomPrenom() {
    nomPrenom.clear();
    notifyListeners();
  }

  void setTelephone(TextEditingController controller) {
    telephone = controller;
    notifyListeners();
  }

  void clearTelephone() {
    telephone.clear();
    notifyListeners();
  }
void setRechercher(TextEditingController controller) {
    rechercher = controller;
    notifyListeners();
  }

  void clearRechercher() {
    rechercher.clear();
    notifyListeners();
  }

}
