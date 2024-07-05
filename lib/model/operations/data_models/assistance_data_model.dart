import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mist_app/model/auth/models/profile_data_model.dart';
import 'package:mist_app/model/operations/data_models/road_data_model.dart';

class AssistanceDataModel {
  String? id;
  String details;
  double latitude;
  double longitude;
  String mobile;
  bool solved;
  DateTime time;
  DocumentReference roadRef;
  DocumentReference userRef;
  RoadDataModel? road;
  ProfileDataModel? user;

  AssistanceDataModel({
    this.id,
    required this.details,
    required this.latitude,
    required this.longitude,
    required this.mobile,
    required this.solved,
    required this.time,
    required this.roadRef,
    required this.userRef,
  });

  factory AssistanceDataModel.fromFirestore(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot}) {
    final data = snapshot.data();
    final String id = snapshot.id;
    final GeoPoint geoPoint = data?["location"] ?? const GeoPoint(0, 0);
    final Timestamp timeStamp = data?['time'] ?? Timestamp(0, 0);

    return AssistanceDataModel(
      latitude: geoPoint.latitude,
      longitude: geoPoint.longitude,
      details: data?['details'] ?? '',
      mobile: data?['mobile'] ?? '',
      solved: data?['solved'] ?? '',
      time: timeStamp.toDate(),
      roadRef: data?['road'] ?? '',
      userRef: data?['user'] ?? '',
      id: id,
    );
  }

  Map<String, dynamic> toFirestore() {
    final geo = GeoPoint(latitude, longitude);
    final timeStamp = Timestamp.fromDate(time);
    return {
      // "id": id,
      "details": details,
      "location": geo,
      "mobile": mobile,
      "road": roadRef,
      "solved": solved,
      "time": timeStamp,
      "user": userRef
    };
  }

  Future<void> load() async {
    // load
    final userDoc =
        await userRef.get() as DocumentSnapshot<Map<String, dynamic>>;
    final roadDoc =
        await roadRef.get() as DocumentSnapshot<Map<String, dynamic>>;
    // parse
    ProfileDataModel loadedUser = ProfileDataModel.fromFirestore(userDoc);

    RoadDataModel loadedRoad = RoadDataModel.fromFirestore(snapshot: roadDoc);

    // assign
    user = loadedUser;
    road = loadedRoad;
    return;
  }

  static getDummyData() {
    final db = FirebaseFirestore.instance;
    DocumentReference roadRef =
        db.collection('roads').doc('i8MdHQY2g7zYjAliOQoe');
    DocumentReference userRef =
        db.collection('users').doc('HLHnUoHz0LhoUra3xAByPatgDUx1');

    return AssistanceDataModel(
        id: '00000000000000000000',
        details: 'my car exploded',
        latitude: 90.0,
        longitude: 90.0,
        mobile: '01021516226',
        solved: false,
        time: DateTime.now(),
        roadRef: roadRef,
        userRef: userRef);
  }

  @override
  String toString() {
    return '@@ Assistance: $id, $details, $latitude, $longitude, $mobile, $solved, $time, $roadRef, $userRef, $road, $user';
  }
}
