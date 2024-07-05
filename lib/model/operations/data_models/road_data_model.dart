import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mist_app/model/auth/models/profile_data_model.dart';
import 'package:mist_app/model/operations/data_models/notification_data_model.dart';
import 'package:mist_app/model/operations/data_models/report_data_model.dart';

class RoadDataModel {
  String rid;
  String name;
  bool isOpen;
  int recSpeed;
  int maxSpeed;
  NotificationDataModel? notification;
  List<DocumentReference> coRefs;
  List<DocumentReference> reportsRefs;
  List<ProfileDataModel> co = [];
  List<ReportDataMdoel> reports = [];

  RoadDataModel({
    required this.rid,
    required this.name,
    required this.isOpen,
    required this.recSpeed,
    required this.maxSpeed,
    required this.coRefs,
    required this.reportsRefs,
    this.notification,
  });
  RoadDataModel.empty(this.name)
      : rid = '',
        isOpen = false,
        recSpeed = 0,
        maxSpeed = 0,
        coRefs = [],
        reportsRefs = [];

  factory RoadDataModel.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
  }) {
    final data = snapshot.data();
    final rid = snapshot.id;
    final Map? notiJson = data?['notification'];
    final notification =
        notiJson != null ? NotificationDataModel.fromJson(notiJson) : null;

    final List<DocumentReference> dataCoRefs = [];
    final List<DocumentReference> dataReportsRefs = [];

    if (data?['co'] != null) {
      for (var e in data?['co']) {
        dataCoRefs.add(e);
      }
    }

    if (data?['reports'] != null) {
      for (var e in data?['reports']) {
        dataReportsRefs.add(e);
      }
    }

    return RoadDataModel(
      rid: rid,
      name: data?['name'] ?? '',
      isOpen: data?['isOpen'] ?? false,
      recSpeed: data?['recSpeed'] ?? 0,
      maxSpeed: data?['maxSpeed'] ?? 0,
      coRefs: dataCoRefs,
      reportsRefs: dataReportsRefs,
      notification: notification,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      // if (name != null) "name": name,
      "name": name,
      "isOpen": isOpen,
      "recSpeed": recSpeed,
      "maxSpeed": maxSpeed,
      "co": coRefs,
      "reports": reportsRefs,
      if (notification != null)
        "notification": {
          "title": notification!.title,
          "content": notification!.content,
        }
    };
  }

  static RoadDataModel getDummyData() {
    return RoadDataModel(
        rid: 'dummy rid',
        name: 'name2',
        isOpen: true,
        recSpeed: 200,
        maxSpeed: 201,
        coRefs: [],
        reportsRefs: []);
  }

  Future<void> load() async {
    // co list
    if (coRefs.isNotEmpty) {
      final coDocs = await Future.wait(coRefs.map((e) => e.get()));
      final coModels = coDocs
          .map((e) => ProfileDataModel.fromFirestore(
              e as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
      co = coModels;
    }

    // reports sorted by time
    if (reportsRefs.isNotEmpty) {
      final db = FirebaseFirestore.instance;
      final reportsDocs = await db
          .collection('reports')
          .where(FieldPath.documentId, whereIn: reportsRefs.map((e) => e.id))
          .where('solved', isEqualTo: false)
          .orderBy('time', descending: true)
          .get();
      List<ReportDataMdoel> reportsModels = reportsDocs.docs
          .map((e) => ReportDataMdoel.fromFirestore(snapshot: e))
          .toList();

      await Future.wait(reportsModels.map((e) => e.load()));
      reports = reportsModels;
    }
    return;
  }

  @override
  String toString() {
    return '@@@ $name, $isOpen, $maxSpeed, $recSpeed, $notification';
  }
}
