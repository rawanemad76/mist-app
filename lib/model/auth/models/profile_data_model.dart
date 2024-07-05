import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mist_app/model/operations/data_models/road_data_model.dart';

int? humRole;

class ProfileDataModel {
  String? fname;
  String? lname;
  String? nid;
  String? email;
  String? phone;
  String? uid;
  int? role;
  String? picUrl;
  DocumentReference? assignedRoadRef;
  RoadDataModel? assignedRoad;

  ProfileDataModel({
    this.fname,
    this.lname,
    this.nid,
    this.email,
    this.phone,
    this.role,
    this.uid,
    this.assignedRoadRef,
  });

  factory ProfileDataModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    final uid = snapshot.id;
    return ProfileDataModel(
      fname: data?["fname"] ?? 'no firstname',
      lname: data?["lname"] ?? 'no lastname',
      nid: data?["nid"] ?? 'no nid',
      email: data?["email"] ?? 'no email',
      phone: data?["phone"] ?? 'no phone',
      role: data?["role"] ?? 4,
      assignedRoadRef: data?["assignedRoad"],
      uid: uid,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (fname != null) "fname": fname,
      if (lname != null) "lname": lname,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
      if (nid != null) "nid": nid,
      if (uid != null) "uid": uid,
      if (role != null) "role": role,
      "assignedRoad": assignedRoadRef,
    };
  }

  Future<void> load() async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final fileRef = storageRef.child('profile_pics').child(uid ?? 'no_id');
      final url = await fileRef.getDownloadURL();
      if (assignedRoadRef != null) {
        final roadDoc = await assignedRoadRef!.get();
        assignedRoad = RoadDataModel.fromFirestore(
            snapshot: roadDoc as DocumentSnapshot<Map<String, dynamic>>);
      }
      picUrl = url;
      return;
    } catch (e) {
      // debugPrint('@@@Ex no img');
    }
    humRole = role;
  }

  @override
  String toString() {
    return """
    fname: $fname
    lname: $lname
    nid: $nid
    email: $email
    phone: $phone
    role: $role
    on_road: $assignedRoadRef
    """;
  }
}
