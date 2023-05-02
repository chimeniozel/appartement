// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Appartement {
  final String? id;
  final String? libele;
  final String? wilaya;
  final GeoPoint? location;
  final String? description;
  final List<String>? images;
  final List<String>? favorisUID;
  final int? nbChamber;
  final int? nbToilette;
  final int? nbCuisines;
  final String? addresse;
  final int? prix;
  final String? propritaire;
  final String? louePar;
  final String? status;
  final bool? forSell;
  Appartement({
    this.id,
    this.libele,
    this.wilaya,
    this.location,
    this.description,
    this.images,
    this.favorisUID,
    this.nbChamber,
    this.nbToilette,
    this.nbCuisines,
    this.addresse,
    this.prix,
    this.propritaire,
    this.louePar,
    this.status,
    this.forSell,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nom": libele,
      "wilaya": wilaya,
      "location": location,
      "description": description,
      "images": images,
      "favorisUID": <String>[],
      "nbChamber": nbChamber,
      "nbToilette": nbToilette,
      "nbCuisines": nbCuisines,
      "addresse": addresse,
      "prix": prix,
      "propritaire": propritaire,
      "louePar": louePar,
      "status": status,
      "for_sell": forSell,
    };
  }

  static Appartement fromJson(Map<String, dynamic> json) => Appartement(
        id: json['id'],
        libele: json['nom'],
        wilaya: json['wilaya'],
        location: json['location'],
        description: json["description"],
        images: json["images"].cast<String>(),
        favorisUID: json["favorisUID"].cast<String>(),
        nbChamber: json["nbChamber"],
        nbToilette: json["nbToilette"],
        nbCuisines: json["nbCuisines"],
        addresse: json["addresse"],
        prix: json["prix"],
        propritaire: json["propritaire"],
        louePar: json["louePar"],
        status: json["status"],
        forSell: json["for_sell"],
      );
  Stream<List<Appartement>> getAppartements(
      {bool? forSell, String? all, String? uid}) {
    if (all == "all") {
      return FirebaseFirestore.instance
          .collection("appartements")
          .where("propritaire", isNotEqualTo: uid)
          .snapshots()
          .map((snapchot) {
        print(snapchot.docs);
        return snapchot.docs
            .map((doc) => Appartement.fromJson(doc.data()))
            .toList();
      });
    }
    else {
      return FirebaseFirestore.instance
          .collection("appartements")
          .where("propritaire", isNotEqualTo: uid)
          .where("for_sell", isEqualTo: forSell)
          .snapshots()
          .map((snapchot) => snapchot.docs
              .map((doc) => Appartement.fromJson(doc.data()))
              .toList());
    }
  }

  Stream<List<Appartement>> getMesAppartement(String uid) {
    return FirebaseFirestore.instance
        .collection("appartements")
        .where("propritaire", isEqualTo: uid)
        .snapshots()
        .map((snapchot) => snapchot.docs
            .map((doc) => Appartement.fromJson(doc.data()))
            .toList());
  }

  Stream<List<Appartement>> getFavoris(String uid) {
    return FirebaseFirestore.instance
        .collection("appartements")
        .where("favorisUID", arrayContains: uid)
        .snapshots()
        .map((snapchot) => snapchot.docs
            .map((doc) => Appartement.fromJson(doc.data()))
            .toList());
  }

  Stream getUIFavoris(String docId) {
    return FirebaseFirestore.instance
        .collection("appartements")
        .doc(docId)
        .snapshots()
        .map((snapchot) => snapchot.get("favorisUID"));
  }
}
