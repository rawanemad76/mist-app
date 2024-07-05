import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/model/operations/data_models/notification_data_model.dart';

abstract class CoordinatorOperations {
  static Future<void> setClosed({required bool isOpen}) async {
    try {
      final json = {"isOpen": isOpen};

      final db = FirebaseFirestore.instance;
      await db.collection('roads').doc(selectedRoadId).update(json);
      return;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> _setNotification(
      {NotificationDataModel? notification}) async {
    try {
      final json = {"notification": notification?.toFirestore()};

      final db = FirebaseFirestore.instance;
      await db.collection('roads').doc(selectedRoadId).update(json);
      return;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> setNotification(
      {required String title, required String content}) async {
    await _setNotification(
        notification: NotificationDataModel(title: title, content: content));
    return;
  }

  static Future<void> removeNotification() async {
    await _setNotification();
    return;
  }

  static Future<void> setSpeed({required int recSpeed, int? maxSpeed}) async {
    try {
      final json = {
        "recSpeed": recSpeed,
        if (maxSpeed != null) "maxSpeed": maxSpeed,
      };

      final db = FirebaseFirestore.instance;
      await db.collection('roads').doc(selectedRoadId).update(json);
      return;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<String?> deleteReport({required String reportId}) async {
    try {
      final json = {"solved": true};
      final db = FirebaseFirestore.instance;
      await db.collection('reports').doc(reportId).update(json);
      return null;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      return e.toString();
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
