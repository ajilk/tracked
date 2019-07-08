import 'package:cloud_firestore/cloud_firestore.dart';

/// Defines an Asset
class Asset {
  final DocumentReference reference;
  final String doe;
  final String serial;
  final String manufacturer;
  final String model;
  final int location;
  final String description;

  Asset.fromMap(Map<String, dynamic> asset, {this.reference})
      : assert(asset['doe'] != null),
        doe = asset['doe'],
        serial = asset['serial'],
        manufacturer = asset['manufacturer'],
        model = asset['model'],
        location = asset['location'],
        description = asset['description'];
        

  Asset.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    return 'Asset Tag: [$doe], Serial Number: [$serial], Manufacturer: [$manufacturer], Model: [$model], Location: [$location], Description: [$description]';
  }
}
