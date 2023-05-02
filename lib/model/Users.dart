// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? id;
  final String? nom;
  final String? telephone;
  final String? email;
  Users({
    this.id,
    this.nom,
    this.telephone,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nom": nom,
      "telephone": telephone,
      "email": email,
    };
  }

  static Users fromJson(Map<String, dynamic>? json) => Users(
        id: json!['id'],
        nom: json['nom'],
        telephone: json['telephone'],
        email: json['email'],
      );
  Stream<Users> getUser(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((snapchot) => Users.fromJson(snapchot.data()));
  }
}
