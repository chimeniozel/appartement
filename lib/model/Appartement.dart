// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Appartement {
  final String? id;
  final String? libele;
  final String? wilaya;
  final GeoPoint? location;
  final String? description;
  final List<String>? images;
  final int? nbChamber;
  final int? nbToilette;
  final String? addresse;
  final int? prix;
  final String? propritaire;
  final String? louePar;
  final String? status;
  Appartement({
    this.id,
    this.libele,
    this.wilaya,
    this.location,
    this.description,
    this.images,
    this.nbChamber,
    this.nbToilette,
    this.addresse,
    this.prix,
    this.propritaire,
    this.louePar,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "id" : id,
      "nom": libele,
      "wilaya": wilaya,
      "location": location,
      "description": description,
      "images": images,
      "nbChamber": nbChamber,
      "nbToilette": nbToilette,
      "addresse": addresse,
      "prix": prix,
      "propritaire": propritaire,
      "louePar": louePar,
      "status": status,
    };
  }

  static Appartement fromJson(Map<String, dynamic> json) => Appartement(
        id: json['id'],
        libele: json['nom'],
        wilaya: json['wilaya'],
        location: json['location'],
        description: json["description"],
        images: json["images"].cast<String>(),
        nbChamber: json["nbChamber"],
        nbToilette: json["nbToilette"],
        addresse: json["addresse"],
        prix: json["prix"],
        propritaire: json["propritaire"],
        louePar: json["louePar"],
        status: json["status"],
      );
  Stream<List<Appartement>> getAppartements() {
    return FirebaseFirestore.instance
        .collection("appartements")
        // .where("id_sous_categorie", isEqualTo: sousCategorieId)
        .snapshots()
        .map((snapchot) => snapchot.docs
            .map((doc) => Appartement.fromJson(doc.data()))
            .toList());
  }
}

final popularInIndonesia = [
  Appartement(
      images: ["assets/apartment-1.jpeg"],
      libele: "The Residences at New City",
      location: const GeoPoint(10, 15),
      description:
          "This property is managed by Beztak, 2022 recipient of the US Best Managed Companies for the third year in a row, sponsored by Deloitte Private and The Wall Street Journal. Call and let us tell you why! ENJOY THE LIFE OF LUXURY Located in Chicago, Illinois The Residences at NewCity offers studio, one-, and two- nbToilette apartments and features a door attendant, covered parking, swimming pool with expansive sundeck, bike racks, BBQ/picnic addresse, and more!",
      wilaya: "4",
      nbChamber: 3,
      nbToilette: 4,
      addresse: "1000",
      prix: 999,
      louePar: "",
      propritaire: "",
      status: "Libre"),
  Appartement(
      images: ["assets/apartment-2.jpeg"],
      libele: "Elevate Tower",
      location: const GeoPoint(10, 15),
      description:
          "This property is managed by Beztak, 2022 recipient of the US Best Managed Companies for the third year in a row, sponsored by Deloitte Private and The Wall Street Journal. Call and let us tell you why! ENJOY THE LIFE OF LUXURY Located in Chicago, Illinois The Residences at NewCity offers studio, one-, and two- nbToilette apartments and features a door attendant, covered parking, swimming pool with expansive sundeck, bike racks, BBQ/picnic addresse, and more!",
      wilaya: "5",
      nbChamber: 5,
      nbToilette: 6,
      addresse: "2300",
      prix: 1599,
      louePar: "",
      propritaire: "",
      status: "Libre"),
  Appartement(
      images: ["assets/apartment-3.png"],
      libele: "1042 on Machigan",
      location: const GeoPoint(10, 15),
      description:
          "This property is managed by Beztak, 2022 recipient of the US Best Managed Companies for the third year in a row, sponsored by Deloitte Private and The Wall Street Journal. Call and let us tell you why! ENJOY THE LIFE OF LUXURY Located in Chicago, Illinois The Residences at NewCity offers studio, one-, and two- nbToilette apartments and features a door attendant, covered parking, swimming pool with expansive sundeck, bike racks, BBQ/picnic addresse, and more!",
      wilaya: "5",
      nbChamber: 3,
      nbToilette: 5,
      addresse: "1700",
      prix: 1399,
      louePar: "",
      propritaire: "",
      status: "Libre"),
  Appartement(
      images: ["assets/apartment-4.jpeg"],
      libele: "Residence Park",
      location: const GeoPoint(10, 15),
      description:
          "This property is managed by Beztak, 2022 recipient of the US Best Managed Companies for the third year in a row, sponsored by Deloitte Private and The Wall Street Journal. Call and let us tell you why! ENJOY THE LIFE OF LUXURY Located in Chicago, Illinois The Residences at NewCity offers studio, one-, and two- nbToilette apartments and features a door attendant, covered parking, swimming pool with expansive sundeck, bike racks, BBQ/picnic addresse, and more!",
      wilaya: "4",
      nbChamber: 3,
      nbToilette: 4,
      addresse: "900",
      prix: 899,
      louePar: "",
      propritaire: "",
      status: "Libre"),
];
