import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/model/auth/models/login_data_model.dart';
import 'package:mist_app/model/auth/models/profile_data_model.dart';
import 'package:mist_app/model/auth/models/sign_up_data_model.dart';

class AuthServices {
  static User? get currentUser => FirebaseAuth.instance.currentUser;

  static Future<ProfileDataModel> getCurrentProfile(
      {bool shouldLoad = false}) async {
    final db = FirebaseFirestore.instance;
    final profileDoc = await db.collection('users').doc(currentUser!.uid).get();
    final profile = ProfileDataModel.fromFirestore(profileDoc);
    if (shouldLoad) await profile.load();
    return profile;
  }

  static Future<void> resendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
      return;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await currentUser!.reauthenticateWithCredential(
          EmailAuthProvider.credential(
              email: currentUser!.email!, password: oldPassword));

      await currentUser!.updatePassword(newPassword);
      return;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> sendResetPasswordEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<ProfileDataModel> logIn(LoginDataModel data) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: data.email!, password: data.password!);

      if (!credential.user!.emailVerified) {
        throw Exception('EMAIL_NOT_VERIFIED_ERROR');
      }
      final profile = await getCurrentProfile();

      return profile;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> signOut() async {
    try {
      selectedRoad = null;
      selectedRoadId = null;

      await FirebaseAuth.instance.signOut();
      debugPrint('@@@ loged out');
      return;
    } catch (e) {
      debugPrint('@@@Ex ${e.toString()}');
      rethrow;
    }
  }

  static Future<void> signUp() async {
    try {
      // create user
      final auth = FirebaseAuth.instance;
      final credential = await auth.createUserWithEmailAndPassword(
          email: signUpDataModel.email!, password: signUpDataModel.password!);

      final db = FirebaseFirestore.instance;
      await db
          .collection('users')
          .doc(credential.user!.uid)
          .set(signUpDataModel.toJson());

      debugPrint('user added with uid: ${credential.user!.uid}');

      // verify email
      await credential.user?.sendEmailVerification();
      debugPrint('email sent');
      return;
    } catch (e) {
      debugPrint('@@@Ex error: ${e.toString()}');
      rethrow;
    }
  }
}
