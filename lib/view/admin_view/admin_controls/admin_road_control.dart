import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/containers/road_cam_num_container.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/show_bottom_sheet/add_road_bottom_sheet.dart';
import 'package:mist_app/constants/colors.dart';
import 'package:mist_app/model/operations/admin_operations.dart';
import 'package:mist_app/model/services/cam_num_services.dart';

class AdminRoadControl extends StatefulWidget {
  const AdminRoadControl({super.key});

  @override
  State<AdminRoadControl> createState() => _AdminRoadControlState();
}

class _AdminRoadControlState extends State<AdminRoadControl> {
  Future<int> _CamNum(String roadName) async {
    try {
      return await CamNumService.getNumberOfCameras(roadName);
    } catch (e) {
      print(e);
      return 0; // return 0 if there is an error
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: AdminOperations.getRoadsNamesAndID(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: snapshot.data!
                              .map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: FutureBuilder(
                              future: _CamNum(e.name),
                              builder: (context, camSnapshot) {
                                if (camSnapshot.connectionState == ConnectionState.waiting) {
                                  return const Loading();
                                } else if (camSnapshot.hasError) {
                                  return Text('Error: ${camSnapshot.error}');
                                } else if (camSnapshot.hasData) {
                                  return RoadCamNumContainer(
                                    name: e.name,
                                    camNum: camSnapshot.data!,
                                  );
                                } else {
                                  return const Text('No data');
                                }
                              },
                            ),
                          ))
                              .toList(),
                        ),
                      );
                    } else {
                      return const Center(child: Loading());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
              context: context,
              builder: (context) {
                return  const AddRoadBottomSheet();
              }).then((_) => setState(() {}));
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 30,
          color: ColorManager.primaryColor,
        ),
      ),
    );
  }
}
