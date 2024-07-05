import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/containers/item_count_helps_container.dart';
import 'package:mist_app/common_widgets/containers/item_details_container.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/my_flutter_app_icons.dart';
import 'package:mist_app/view/admin_view/admin_controls/admin_accidents_control.dart';
import 'package:mist_app/view/admin_view/admin_controls/admin_assistances_control.dart';
import 'package:mist_app/view/admin_view/admin_controls/admin_coordinators_control.dart';
import 'package:mist_app/view/admin_view/admin_controls/admin_road_control.dart';
import 'package:mist_app/view/admin_view/admin_profile.dart';
import '../../model/operations/admin_operations.dart';
import '../../model/operations/data_models/counts_data_model.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminProfileView(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.person,
                        size: 45,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder<int?>(
                      future: AdminOperations.getUsersCount(),
                      builder:
                          (BuildContext context, AsyncSnapshot<int?> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          int? usersCount = snapshot.data;
                          return ItemsCountDetailsContainer(
                            name: 'Number of users',
                            count: usersCount ?? 0,
                            iconName: const Icon(Icons.people_alt_outlined),
                            onPressed: () {},
                            iconPressed: const Icon(
                              MyFlutterApp.group,
                              size: 0,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox20(),
                    FutureBuilder<int?>(
                      future: AdminOperations.getRoadsCount(),
                      builder:
                          (BuildContext context, AsyncSnapshot<int?> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error : ${snapshot.error}");
                        } else {
                          int? roadsCount = snapshot.data;
                          return ItemsCountDetailsContainer(
                            name: "Roads",
                            count: roadsCount ?? 0,
                            iconName: const Icon(MyFlutterApp.road),
                            iconPressed:
                                const Icon(MyFlutterApp.group, size: 15),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminRoadControl(),
                                ),
                              ).then((_) => setState(() {}));
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox20(),
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminCoordinatorsControl(),
                                ),
                              ).then((value) => setState(() {}));
                            },
                            iconPressed: const Icon(
                              MyFlutterApp.group,
                              size: 15,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox20(),
                    FutureBuilder<CountsDataModel>(
                      future: AdminOperations.getReportsCounts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<CountsDataModel> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return const Center(child: Loading(),);
                        } else {
                          CountsDataModel countsData = snapshot.data!;
                          return ItemsCountHelpsContainer(
                            name: "Accidents",
                            totalCount: countsData.all,
                            resolvedCount: countsData.solvedCount,
                            unResolvedCount: countsData.notSolvedCount,
                            iconName: const Icon(MyFlutterApp.carCrash),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminAccidentsControl()));
                            },
                            iconPressed: const Icon(
                              MyFlutterApp.group,
                              size: 15,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox20(),
                    FutureBuilder<CountsDataModel>(
                      future: AdminOperations.getRequestsCounts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<CountsDataModel> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData) {
                          return const Center(child: Loading(),);
                        } else {
                          CountsDataModel countsData = snapshot.data!;
                          return ItemsCountHelpsContainer(
                            name: "Assistances",
                            totalCount: countsData.all,
                            resolvedCount: countsData.solvedCount,
                            unResolvedCount: countsData.notSolvedCount,
                            iconName: const Icon(MyFlutterApp.carService),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminAssistancesControl()));
                            },
                            iconPressed: const Icon(
                              MyFlutterApp.group,
                              size: 15,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox20(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
