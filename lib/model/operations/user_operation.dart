import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/model/auth/auth_services.dart';
import 'package:mist_app/model/operations/data_models/report_data_model.dart';
import 'package:mist_app/model/operations/data_models/assistance_data_model.dart';
import 'package:mist_app/model/operations/data_models/road_data_model.dart';

class UserOperations {
  static Future<List<AssistanceDataModel>> getAssistances({
    required String roadId,
    required bool byUser,
    required bool onSelectedRoad,
    bool notSolvedOnly = false,
  }) async {
    try {
      final userId = AuthServices.currentUser!.uid;

      final db = FirebaseFirestore.instance;
      final roadRef = db.collection('roads').doc(roadId);
      final userRef = db.collection('users').doc(userId);

      var assistancesQuery =
          db.collection('requests').orderBy('time', descending: true);

      if (byUser) {
        assistancesQuery = assistancesQuery.where('user', isEqualTo: userRef);
        if (onSelectedRoad) {
          assistancesQuery = assistancesQuery.where('road', isEqualTo: roadRef);
        }
      } else {
        assistancesQuery = assistancesQuery
            .where('user', isNotEqualTo: userRef)
            .where('road', isEqualTo: roadRef);
      }

      if (notSolvedOnly) {
        assistancesQuery = assistancesQuery.where('solved', isEqualTo: false);
      }
      final assistancesRes = await assistancesQuery.get();

      if (assistancesRes.docs.isEmpty) {
        return [];
      }

      final assistancesDocs = assistancesRes.docs;
      final assistances = assistancesDocs
          .map((e) => AssistanceDataModel.fromFirestore(snapshot: e))
          .toList();

      List<Future> loaded = [];
      for (AssistanceDataModel element in assistances) {
        loaded.add(element.load());
      }
      await Future.wait(loaded);

      print('@@@@@@ ${assistances[0].solved}');
      return assistances;
    } catch (e) {
      debugPrint('@@@#Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> postAssistance({
    required String contactInfo,
    required String details,
    required double latitude,
    required double longitude,
  }) async {
    try {
      DateTime time = DateTime.now();
      final db = FirebaseFirestore.instance;
      final userId = AuthServices.currentUser!.uid;
      final roadRef = db.collection('roads').doc(selectedRoadId);
      final userRef = db.collection('users').doc(userId);
      final AssistanceDataModel assistance = AssistanceDataModel(
        mobile: contactInfo,
        details: details,
        latitude: latitude,
        longitude: longitude,
        solved: false,
        time: time,
        roadRef: roadRef,
        userRef: userRef,
      );
      await db.collection('requests').add(assistance.toFirestore());
    } catch (e) {
      debugPrint('@@@Ex $e');
      rethrow;
    }
  }

  static Future<void> postReport({
    required String details,
    required double longitude,
    required double latitude,
    required String type,
    required File? image,
  }) async {
    try {
      final db = FirebaseFirestore.instance;
      // get Current time
      DateTime time = DateTime.now();
      // user ref
      final uid = AuthServices.currentUser!.uid;
      final userRef = db.collection('users').doc(uid);

      // road ref
      final roadRef = db.collection('roads').doc(selectedRoadId);

      // road model
      final report = ReportDataMdoel(
          details: details,
          longitude: longitude,
          latitude: latitude,
          solved: false,
          time: time,
          type: type,
          userRef: userRef,
          roadRef: roadRef);

      // upload report
      final reportRef =
          await db.collection('reports').add(report.toFirestore());
      final reportId = reportRef.id;

      // update road.reports
      await db.collection('roads').doc(selectedRoadId).update({
        'reports': FieldValue.arrayUnion([reportRef])
      });

      // upload pic
      if (image != null) {
        final storageRef = FirebaseStorage.instance.ref();
        final fileRef = storageRef.child('reports').child(reportId);
        await fileRef.putFile(image);
        // print('@@@ download: ${await fileRef.getDownloadURL()}');
      }
    } catch (e) {
      debugPrint('@@@ ${e.toString()}');
      rethrow;
    }
  }

  static Future<RoadDataModel> getRoad(String roadId) async {
    try {
      // final res = await db.collection('roads').doc(selectedRoadId).get();
      final db = FirebaseFirestore.instance;
      final roadDoc = await db.collection('roads').doc(roadId).get();
      final road = RoadDataModel.fromFirestore(snapshot: roadDoc);

      await road.load();

      return road;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<RoadDataModel> getRoadForCurrentCoordinator() async {
    try {
      // get rid
      final profile = await AuthServices.getCurrentProfile();
      if (profile.assignedRoadRef == null) throw Exception('No assigned Road');
      final roadId = profile.assignedRoadRef!.id;

      // get road
      final db = FirebaseFirestore.instance;
      final roadRef = db.collection('roads').doc(roadId);
      final res = await roadRef.get();
      final road = RoadDataModel.fromFirestore(snapshot: res);
      await road.load();
      return road;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> updateProfilePic(File pic) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final String id = AuthServices.currentUser!.uid;
      final fileRef = storageRef.child('profile_pics').child(id);
      await fileRef.putFile(pic);
      // print('@@@ download: ${await fileRef.getDownloadURL()}');
    } catch (e) {
      debugPrint('@@@ ${e.toString()}');
      rethrow;
    }
  }

  static Future<Uint8List?> getProfilePic(String id) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final fileRef = storageRef.child('profile_pics').child(id);
      final img = await fileRef.getData();
      return img;
    } catch (e) {
      debugPrint('@@@ ${e.toString()}');
      rethrow;
    }
  }

  static Future<List<ReportDataMdoel>> getReports({
    required String roadId,
    bool isArchived = false,
  }) async {
    try {
      final db = FirebaseFirestore.instance;
      final roadRef = db.collection('roads').doc(roadId);
      final reportDocs = await db
          .collection('reports')
          .where('road', isEqualTo: roadRef)
          .where('isArchived', isEqualTo: isArchived)
          .orderBy('time', descending: true)
          .get();
      final reports = reportDocs.docs
          .map((e) => ReportDataMdoel.fromFirestore(snapshot: e))
          .toList();

      await Future.wait(reports.map((e) => e.load()));
      return reports;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<String?> setSolved({required String assistanceId}) async {
    try {
      final json = {"solved": true};
      final db = FirebaseFirestore.instance;
      await db.collection('requests').doc(assistanceId).update(json);
      return null;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      return e.toString();
    }
  }
}
