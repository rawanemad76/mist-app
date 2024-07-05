import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/containers/custom_container.dart';
import 'package:mist_app/common_widgets/containers/item_details_container.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/view/admin_view/admin_controls/add_coordinator.dart';
import '../../../model/operations/admin_operations.dart';
import '../../../my_flutter_app_icons.dart';

class AdminCoordinatorsControl extends StatefulWidget {
  const AdminCoordinatorsControl({super.key});

  @override
  State<AdminCoordinatorsControl> createState() =>
      _AdminCoordinatorsControlState();
}

class _AdminCoordinatorsControlState extends State<AdminCoordinatorsControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  FutureBuilder<int?>(
                    future: AdminOperations.getCoordinatorsCount(),
                    builder:
                        (BuildContext context, AsyncSnapshot<int?> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        int? coordinatorCount = snapshot.data;
                        return ItemsCountDetailsContainer(
                          name: "Coordinators",
                          count: coordinatorCount ?? 0,
                          iconName: const Icon(Icons.person_outlined),
                          iconPressed: const Icon(
                            MyFlutterApp.group,
                            size: 0,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 60),
                  FutureBuilder(
                    future: AdminOperations.getRoadsNamesAndID(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SelectRoadDropdownButton(
                            itemsList: snapshot.data!);
                      } else {
                        return const Center(child: Loading(),);
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                      text: "show",
                      onTap: () {
                        if (selectedRoadId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('please select a road')));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddCoordinator(),
                            ),
                          ).then((value) => setState(() {}));
                        }
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  FutureBuilder(
                    future: AdminOperations.getRoadsWithNoCo(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String roadsWithNoCo = '';
                        for (var e in snapshot.data!) {
                          roadsWithNoCo = '$roadsWithNoCo${e.name}, ';
                        }
                        // remove last comma
                        roadsWithNoCo = roadsWithNoCo.substring(
                            0, roadsWithNoCo.length - 2);
                        return CustomContainer(
                          title: 'Roads Without Coordinators: ',
                          statusRoad: roadsWithNoCo,
                          showHeader: false,
                          height: 130,
                          onTap: () {},
                        );
                      } else {
                        return const Center(child: Loading());
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
