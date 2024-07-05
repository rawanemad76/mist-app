import 'package:cloud_firestore/cloud_firestore.dart';

class RoadHeaderDataModel extends Object {
  String name;
  String id;

  RoadHeaderDataModel({
    required this.name,
    required this.id,
  });

  factory RoadHeaderDataModel.fromFirestore(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot}) {
    final data = snapshot.data();
    final id = snapshot.id;
    return RoadHeaderDataModel(name: data?["name"], id: id);
  }

  @override
  String toString() {
    return 'road name: $name, road id $id';
  }
}
