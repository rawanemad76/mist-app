import 'package:flutter/material.dart';
import 'package:mist_app/view/admin_view/admin_home_screen.dart';
import 'package:mist_app/view/coordinator_view/coordinator_nav_bar.dart';
import 'package:mist_app/view/registration/login_screen.dart';
import 'package:mist_app/view/user_view/select_road.dart';

import 'constants/strings.dart';
import 'model/auth/auth_services.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    _handleAuth(context);
    return Container();
  }

  _handleAuth(BuildContext context) async {
    if (AuthServices.currentUser != null) {
      try {
        final profile = await AuthServices.getCurrentProfile();
        debugPrint('@@@ role: ${profile.role}');
        Widget? targetScreen;
        switch (profile.role) {
          case 1:
            targetScreen = const AdminHomeScreen();
            break;
          case 2:
            targetScreen = const CoordinatorNavBar(); // TODO no selected road
            break;
          case 3:
            targetScreen = const SelectRoad();
            break;
        }
        if (!context.mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => targetScreen!),
          (route) => false,
        );
      } catch (e) {
        final SnackBar s;
        if (e.toString() == emailNotVerifiedError) {
          s = SnackBar(
            content: const Text('verify your email'),
            action: SnackBarAction(
                label: 'resend email',
                onPressed: () => AuthServices.resendVerificationEmail()),
          );
        } else {
          s = SnackBar(content: Text(e.toString()));
        }
        ScaffoldMessenger.of(context).showSnackBar(s);
      }
    } else {
      await Future.delayed(Durations.short1);
      if (!context.mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }
}
