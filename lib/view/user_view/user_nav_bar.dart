import 'package:flutter/material.dart';
import 'package:mist_app/view/common_view/accident_view.dart';
import 'package:mist_app/view/common_view/assistance_view.dart';
import 'package:mist_app/view/user_view/user_home_screen.dart';
import 'package:mist_app/view/common_view/profile_view.dart';
import 'package:mist_app/view/common_view/request_assistance_view.dart';
import '../../constants/colors.dart';
import '../../my_flutter_app_icons.dart';

class UserNavBar extends StatefulWidget {
  const UserNavBar({super.key});

  @override
  State<UserNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<UserNavBar> {
  int index = 0;
  List<Widget> userViews = [
    const UserHomeScreen(),
    const AccidentView(),
    const AssistanceView(notSolvedOnly: true),
    const RequestAssistanceView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorManager.primaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        backgroundColor: Colors.white,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        iconSize: 30,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.carCrash), label: "Car Crash"),
          BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.carService), label: "Car Service"),
          BottomNavigationBarItem(
            icon: Icon(Icons.real_estate_agent_rounded),
            label: "request assistance",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "person"),
        ],
      ),
      body: userViews[index],
    );
  }
}
