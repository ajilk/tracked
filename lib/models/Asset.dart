import 'package:cloud_firestore/cloud_firestore.dart';

/// Defines an Asset
class Asset {
  DocumentReference reference;
  String doe;
  String serial;
  String manufacturer;
  String model;
  String location;
  String description;

  Asset.fromMap(Map<String, dynamic> asset, {this.reference})
      : doe = asset['doe'],
        serial = asset['serial'],
        manufacturer = asset['manufacturer'],
        model = asset['model'],
        location = asset['location'],
        description = asset['description'];

  Asset.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  Map toMap() {
    var map = Map<String, dynamic>();
    map['doe'] = doe;
    map['serial'] = serial;
    map['manufacturer'] = manufacturer;
    map['model'] = model;
    map['location'] = location;
    map['description'] = description;
    return map;
  }
  

  @override
  String toString() {
    return 'Asset Tag: [$doe], Serial Number: [$serial], Manufacturer: [$manufacturer], Model: [$model], Location: [$location], Description: [$description]';
  }
}
