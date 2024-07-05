import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/model/auth/auth_services.dart';
import 'package:mist_app/view/coordinator_view/coordinator_home_screen.dart';
import '../../constants/colors.dart';
import '../../my_flutter_app_icons.dart';
import '../common_view/accident_view.dart';
import '../common_view/assistance_view.dart';
import '../common_view/profile_view.dart';
import '../common_view/request_assistance_view.dart';

class CoordinatorNavBar extends StatefulWidget {
  const CoordinatorNavBar({super.key});

  @override
  State<CoordinatorNavBar> createState() => _CoordinatorNavBarState();
}

class _CoordinatorNavBarState extends State<CoordinatorNavBar> {
  int index = 0;

  final coordinatorViews = [
    const CoordinatorHomeScreen(),
    const AccidentView(),
    const AssistanceView(canSetSolved: true, notSolvedOnly: true),
    const RequestAssistanceView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthServices.getCurrentProfile(shouldLoad: true),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          selectedRoad = snapshot.data!.assignedRoad!.name;
          selectedRoadId = snapshot.data!.assignedRoad!.rid;
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: ColorManager.primaryColor,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              showSelectedLabels: false,
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
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "person"),
              ],
            ),
            body: coordinatorViews[index],
          );
        } else {
          return   const Center(child: Loading());
        }
      },
    );
  }
}
