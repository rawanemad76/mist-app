// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserInfoModel {
//   String? fname;
//   String? lname;
//   String? email;
//   String? nid;
//   String? uid;
//   int? role;
//   DocumentReference? road;

//   UserInfoModel({
//     required this.fname,
//     required this.lname,
//     required this.nid,
//     required this.email,
//     required this.uid,
//     this.role,
//     this.road,
//   });

//   factory UserInfoModel.fromFirestore({
//     required DocumentSnapshot<Map<String, dynamic>> snapshot,
//   }) {
//     final data = snapshot.data();
//     final String uid = snapshot.id;

//     return UserInfoModel(
//       email: data?["email"],
//       fname: data?["fname"],
//       lname: data?["lname"],
//       nid: data?["nid"],
//       role: data?["role"],
//       road: data?['road'],
//       uid: uid,
//     );
//   }
// //     required this.fname,
// //     required this.lname,
// //     required this.nid,
// //     required this.email,
// //     required this.uid,
// //     this.role,
// //     this.road,

//   static UserInfoModel getDummyData() {
//     return UserInfoModel(
//       fname: 'fname',
//       lname: 'lname',
//       nid: 'nid',
//       email: 'email',
//       uid: 'uid',
//     );
//   }

//   Map<String, dynamic> toFirestore() {
//     return {
//       if (fname != null) "fname": fname,
//       if (lname != null) "lname": lname,
//       if (email != null) "email": email,
//       if (nid != null) "nid": nid,
//       if (uid != null) "uid": uid,
//       if (role != null) "role": role,
//       "road": road,
//     };
//   }

//   @override
//   String toString() {
//     return '@@@ user: $fname, $lname, $email, $nid, $uid, $role, $road';
//   }
// }
