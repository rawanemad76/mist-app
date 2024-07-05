import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/containers/item_count_helps_container.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/constants/colors.dart';
import 'package:mist_app/my_flutter_app_icons.dart';
import 'package:mist_app/view/admin_view/admin_controls/show_accident_history.dart';

import '../../../model/operations/admin_operations.dart';
import '../../../model/operations/data_models/counts_data_model.dart';

class AdminAccidentsControl extends StatelessWidget {
  const AdminAccidentsControl({super.key});

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
                  FutureBuilder<CountsDataModel>(
                    future: AdminOperations.getReportsCounts(),
                    builder: (BuildContext context, AsyncSnapshot<CountsDataModel> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return const CircularProgressIndicator(
                          color: ColorManager.primaryColor,
                        );
                      } else {
                        CountsDataModel countsData = snapshot.data!;
                        return ItemsCountHelpsContainer(
                          name: "Accidents",
                          totalCount: countsData.all,
                          resolvedCount: countsData.solvedCount ,
                          unResolvedCount: countsData.notSolvedCount ,
                          iconName: const Icon(MyFlutterApp.road),
                          iconPressed: const Icon(
                            MyFlutterApp.group,
                            size: 0,
                          ),
                        );
                      }
                    },
                  ),

                  const SizedBox(
                    height: 60,
                  ),
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
                  const SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      text: "Show accident History",
                      onTap: () {
                        if (selectedRoadId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('please select a road')));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const ShowAccidentHistory()));
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
