import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/model/auth/models/profile_data_model.dart';
import 'package:mist_app/model/operations/data_models/counts_data_model.dart';
import 'package:mist_app/model/operations/data_models/report_data_model.dart';
import 'package:mist_app/model/operations/data_models/road_data_model.dart';
import 'package:mist_app/model/operations/data_models/road_header_data_model.dart';

abstract class AdminOperations {
  static Future<int?> _getUsersCount(int role) async {
    try {
      final db = FirebaseFirestore.instance;
      final res = await db
          .collection('users')
          .where("role", isEqualTo: role)
          .count()
          .get();
      return res.count;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<int?> getUsersCount() async {
    return await _getUsersCount(3);
  }

  static Future<int?> getCoordinatorsCount() async {
    return await _getUsersCount(2);
  }

  static Future<List<ProfileDataModel>> getCoordinators() async {
    try {
      final db = FirebaseFirestore.instance;
      final roadRef = db.collection('roads').doc(selectedRoadId);

      final coDocs = await db
          .collection('users')
          .where('assignedRoad', isEqualTo: roadRef)
          .get();

      final coModels =
          coDocs.docs.map((e) => ProfileDataModel.fromFirestore(e)).toList();
      await Future.wait(coModels.map((e) => e.load()));
      return coModels;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<int?> getRoadsCount() async {
    try {
      final db = FirebaseFirestore.instance;
      final res = await db.collection('roads').count().get();
      return res.count;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<List<RoadHeaderDataModel>> getRoadsNamesAndID() async {
    try {
      // get
      final db = FirebaseFirestore.instance;
      final res = await db.collection('roads').get();
      final docs = res.docs;

      // parse
      final roads = <RoadHeaderDataModel>[];
      for (var element in docs) {
        final road = RoadHeaderDataModel.fromFirestore(snapshot: element);
        roads.add(road);
      }
      return roads;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<List<ReportDataMdoel>?> getReportsForRoad() async {
    try {
      final db = FirebaseFirestore.instance;

      // get road doc
      final roadDoc = await db.collection('roads').doc(selectedRoadId).get();
      final roadData = roadDoc.data();

      // get reports refs
      final reportsRefs = roadData!["reports"];

      // get reports snapshot
      // final List<Future> reportsDocsFutures = [];
      // for (int i = 0; i < reportsRefs.length; i++) {
      //   reportsDocsFutures.add(reportsRefs[i].get());
      // }
      // final reportsDocsSnapshots = await Future.wait(reportsDocsFutures);

      final reportsDocsSnapshots = await db
          .collection('reports')
          .where(FieldPath.documentId, whereIn: reportsRefs)
          .orderBy('time', descending: true)
          .get();

      final reportsDocs = reportsDocsSnapshots.docs;

      // parse and load
      final List<Future> loadedReportsFutures = [];
      final List<ReportDataMdoel> reports = [];
      for (int i = 0; i < reportsDocs.length; i++) {
        ReportDataMdoel report =
            ReportDataMdoel.fromFirestore(snapshot: reportsDocs[i]);

        reports.add(report);
        loadedReportsFutures.add(report.load());
      }
      await Future.wait(loadedReportsFutures);
      // print('@@@ ${reports}');
      return reports;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> addCoForRoad(
      {required String userEmail, required String roadId}) async {
    try {
      final db = FirebaseFirestore.instance;
      final userRes = await db
          .collection('users')
          .where("email", isEqualTo: userEmail)
          .get();
      // assert(res.docs.length == 1);
      final userDoc = userRes.docs[0];
      final userModel = ProfileDataModel.fromFirestore(userDoc);
      final userRef = userDoc.reference;

      final roadDoc = await db.collection('roads').doc(roadId).get();
      final road = RoadDataModel.fromFirestore(snapshot: roadDoc);

      if (road.coRefs.contains(userRef)) {
        throw Exception('User is Already a Coordinator on this road');
      }
      if (userModel.role == 2 && userModel.assignedRoadRef != null) {
        throw Exception('User is Already Coordinator on another road');
      }
      // add co to road
      road.coRefs.add(userRef);
      db.collection('roads').doc(selectedRoadId).update(road.toFirestore());

      // promote user
      userModel.role = 2;
      userModel.assignedRoadRef =

          // add road to user
          userModel.assignedRoadRef = roadDoc.reference;
      db.collection('users').doc(userModel.uid).update(userModel.toFirestore());
      return;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> removeCoFromRoad({required String userEmail}) async {
    try {
      final db = FirebaseFirestore.instance;
      final userRes = await db
          .collection('users')
          .where("email", isEqualTo: userEmail)
          .get();
      final userDoc = userRes.docs[0];
      final userModel = ProfileDataModel.fromFirestore(userDoc);
      final userRef = userDoc.reference;

      final roadDoc = await db.collection('roads').doc(selectedRoadId).get();
      final road = RoadDataModel.fromFirestore(snapshot: roadDoc);

      // if (road.coRefs.contains(userRef)) {
      //   throw Exception('User is Already a Coordinator on this road');
      // }
      // if (userModel.role == 2) {
      //   throw Exception('User is Already Coordinator on another road');
      // }

      // remove co from road
      road.coRefs.remove(userRef);
      db.collection('roads').doc(selectedRoadId).update(road.toFirestore());

      // reset co to user
      userModel.role = 3;

      // remove road from user
      userModel.assignedRoadRef = null;
      await db
          .collection('users')
          .doc(userModel.uid)
          .update(userModel.toFirestore());
      return;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }
  // ====================================================================================================

  static Future<int?> _getCounts(String collection, bool isSolved) async {
    final db = FirebaseFirestore.instance;
    final res = await db
        .collection(collection)
        .where("solved", isEqualTo: isSolved)
        .count()
        .get();
    return res.count;
  }

  static Future<int?> _getCountsForRoad(
    String collection,
    String roadID,
    bool isSolved,
  ) async {
    final db = FirebaseFirestore.instance;
    final road = db.collection('roads').doc(roadID);
    final res = await db
        .collection(collection)
        .where("road", isEqualTo: road)
        .where("solved", isEqualTo: isSolved)
        .count()
        .get();
    return res.count;
  }

//================================================================================================
  static Future<CountsDataModel> getReportsCounts() async {
    try {
      // final solvedCount = await _getCounts('reports', true);
      // final notSolvedCount = await _getCounts('reports', false);
      // return CountsDataModel(s: solvedCount, n: notSolvedCount);

      final counts = await Future.wait([
        _getCounts('reports', true),
        _getCounts('reports', false),
      ]);

      return CountsDataModel(solved: counts[0], notSolved: counts[1]);
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<CountsDataModel> getReportsCountsForRoad() async {
    try {
      final solvedCount =
          await _getCountsForRoad('reports', selectedRoadId!, true);
      final notSolvedCount =
          await _getCountsForRoad('reports', selectedRoadId!, false);

      return CountsDataModel(solved: solvedCount, notSolved: notSolvedCount);
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<CountsDataModel> getRequestsCounts() async {
    try {
      final solvedCount = await _getCounts('requests', true);
      final notSolvedCount = await _getCounts('requests', false);

      return CountsDataModel(solved: solvedCount, notSolved: notSolvedCount);
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<CountsDataModel> getRequestsCountsForRoad() async {
    try {
      final solvedCount =
          await _getCountsForRoad('requests', selectedRoadId!, true);
      final notSolvedCount =
          await _getCountsForRoad('requests', selectedRoadId!, false);

      return CountsDataModel(solved: solvedCount, notSolved: notSolvedCount);
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<List<RoadDataModel>> getRoadsWithNoCo() async {
    try {
      final db = FirebaseFirestore.instance;
      final res = await db.collection('roads').where("co", isEqualTo: [])
          // .where(Filter.or(
          //   Filter("co", isNull: true),
          //   Filter("co", isEqualTo: []),
          // ))
          .get();
      final roadsDocs = res.docs;
      final roads = <RoadDataModel>[];

      if (roadsDocs.isNotEmpty) {
        for (var i = 0; i < roadsDocs.length; i++) {
          roads.add(RoadDataModel.fromFirestore(snapshot: roadsDocs[i]));
        }
      }

      return roads;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<String?> addRoad(RoadDataModel road) async {
    try {
      final db = FirebaseFirestore.instance;
      await db.collection('roads').add(road.toFirestore());

      return null;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      return e.toString();
    }
  }
}
