import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mist_app/model/auth/models/profile_data_model.dart';
import 'package:mist_app/model/operations/data_models/road_data_model.dart';

class ReportDataMdoel {
  String? rid;
  String details;
  double latitude;
  double longitude;
  bool solved;
  DateTime time;
  String type;
  DocumentReference roadRef;
  DocumentReference userRef;
  ProfileDataModel? user;
  RoadDataModel? road;
  String? imgUrl;
  bool isArchived;

  ReportDataMdoel({
    this.rid,
    required this.details,
    required this.longitude,
    required this.latitude,
    required this.solved,
    required this.time,
    required this.type,
    required this.userRef,
    required this.roadRef,
    this.isArchived = false,
  });

  factory ReportDataMdoel.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
  }) {
    final data = snapshot.data();
    final rid = snapshot.id;
    final GeoPoint geoPoint = data?["location"] ?? const GeoPoint(0, 0);
    final Timestamp timeStamp = data?['time'] ?? Timestamp(0, 0);

    return ReportDataMdoel(
        rid: rid,
        details: data?['details'] ?? '',
        latitude: geoPoint.latitude,
        longitude: geoPoint.longitude,
        solved: data?["solved"] ?? false,
        time: timeStamp.toDate(),
        type: data?["type"] ?? '',
        userRef: data?["user"],
        roadRef: data?["road"],
        isArchived: data?["isArchived"]);
  }

  Map<String, dynamic> toFirestore() {
    final geo = GeoPoint(latitude, longitude);
    final timeStamp = Timestamp.fromDate(time);
    return {
      // "id": id,
      "details": details,
      "location": geo,
      "road": roadRef,
      "solved": solved,
      "time": timeStamp,
      "type": type,
      "user": userRef,
      "isArchived": isArchived,
    };
  }

  Future<void> load() async {
    // load
    final userDoc =
        await userRef.get() as DocumentSnapshot<Map<String, dynamic>>;

    final roadDoc =
        await roadRef.get() as DocumentSnapshot<Map<String, dynamic>>;

    imgUrl = await _checkImg();

    // parse
    ProfileDataModel userModel = ProfileDataModel.fromFirestore(userDoc);
    await userModel.load();
    RoadDataModel roadModel = RoadDataModel.fromFirestore(snapshot: roadDoc);

    // assign
    user = userModel;
    road = roadModel;

    return;
  }

  _checkImg() async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final fileRef = storageRef.child('reports').child(rid!);
      return await fileRef.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  static getDummyData() {
    final db = FirebaseFirestore.instance;
    DocumentReference roadRef =
        db.collection('roads').doc('i8MdHQY2g7zYjAliOQoe');
    DocumentReference userRef =
        db.collection('users').doc('HLHnUoHz0LhoUra3xAByPatgDUx1');

    return ReportDataMdoel(
      details: 'details',
      longitude: 16,
      latitude: 16,
      solved: false,
      time: DateTime.now(),
      type: 'type',
      userRef: userRef,
      roadRef: roadRef,
      isArchived: false,
    );
  }

  @override
  String toString() {
    return '@@@Report: $rid, $details, $longitude, $latitude, $solved, $time, $type, $isArchived, $userRef, $user, $roadRef, $road';
  }
}
