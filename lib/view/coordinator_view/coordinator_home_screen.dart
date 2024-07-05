import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/main_body.dart';
import 'package:mist_app/constants/colors.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/operations/user_operation.dart';
import '../../common_widgets/loading.dart';
import '../../common_widgets/show_bottom_sheet/Add_or_delete_Notification_bottom_sheet.dart';
import '../../common_widgets/show_bottom_sheet/edit_notify_bottom_sheet.dart';
import '../../common_widgets/show_bottom_sheet/edit_road_status.dart';
import '../../common_widgets/show_bottom_sheet/remove_accident_details_bottom_sheet.dart';
import '../../common_widgets/show_bottom_sheet/speed_bottom_sheet.dart';

class CoordinatorHomeScreen extends StatefulWidget {
  const CoordinatorHomeScreen({super.key});

  @override
  State<CoordinatorHomeScreen> createState() => _CoordinatorHomeScreenState();
}

class _CoordinatorHomeScreenState extends State<CoordinatorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: FutureBuilder(
                future: UserOperations.getRoadForCurrentCoordinator(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(snapshot.error.toString())));
                    return Container();
                  } else {
                    if (snapshot.hasData) {
                      selectedRoadId = snapshot.data!.rid;
                      selectedRoad = snapshot.data!.name;
                      return MainBody(
                        currentRoad: snapshot.data!.name,
                        maxSpeed: snapshot.data!.maxSpeed.toString(),
                        recommendSpeed: snapshot.data!.recSpeed.toString(),
                        isOpen: snapshot.data!.isOpen,
                        notification: snapshot.data!.notification,
                        reports: snapshot.data!.reports,
                        onTapNotification: snapshot.data!.notification == null
                            ? null : () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return EditNotificationBottomSheet(
                                          noti: snapshot.data!.notification!);
                                    }).then((_) => setState(() {}));},
                        onTapReport: snapshot.data!.reports.isEmpty
                            ? null : () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return RemoveAccidentDetailsBottomSheet(
                                          reportId:
                                              snapshot.data!.reports[0].rid!);
                                    }).then((_) => setState(() {}));
                              },
                      );
                    } else {
                      return const Loading();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        // animatedIcon: AnimatedIcons.menu_close,
        buttonSize: const Size(50, 50),
        icon: Icons.edit,
        elevation: 8,
        backgroundColor: Colors.white,
        overlayOpacity: 0.3,
        spacing: 10,
        iconTheme: const IconThemeData(color: ColorManager.primaryColor),
        children: [
          SpeedDialChild(
            shape: const CircleBorder(),
            child: const Icon(
              Icons.edit_notifications,
              color: ColorManager.primaryColor,
            ),
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const AddOrDeleteNotificationBottomSheet();
                  }).then((_) => setState(() {}));
            },
          ),
          SpeedDialChild(
            shape: const CircleBorder(),
            child: const Icon(
              Icons.speed,
              color: ColorManager.primaryColor,
            ),
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const SpeedBottomSheet();
                  }).then((_) => setState(() {}));
            },
          ),
          SpeedDialChild(
            shape: const CircleBorder(),
            child: const Icon(
              Icons.lock_open,
              color: ColorManager.primaryColor,
            ),
            onTap: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return const EditRoadStatusBottomSheet();
                  }).then((_) => setState(() {}));
            },
          ),
        ],
      ),
    );
  }


}
