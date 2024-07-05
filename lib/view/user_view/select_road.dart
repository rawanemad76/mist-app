import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mist_app/common_widgets/images/custom_images.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/texts/default_title.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/colors.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/home_view_cubit/get_road_cubit/get_road_cubit.dart';
import 'package:mist_app/model/operations/admin_operations.dart';
import 'package:mist_app/model/operations/data_models/road_header_data_model.dart';
import 'package:mist_app/view/user_view/user_nav_bar.dart';

class SelectRoad extends StatefulWidget {
  const SelectRoad({super.key});

  @override
  State<SelectRoad> createState() => _SelectRoadState();
}

class _SelectRoadState extends State<SelectRoad> {
  late Future<List<RoadHeaderDataModel>> dataFuture;

  // String? selectedRoad;
  // List itemsList = [
  //   "Road w",
  //   "Road X",
  //   "Road Y",
  //   "Road Z",
  // ];

  @override
  void initState() {
    super.initState();
    dataFuture = AdminOperations.getRoadsNamesAndID();
  }

  @override
  Widget build(BuildContext context) {
    // AuthServices.logIn(
    //     LoginDataModel(email: 'za2530163@gmail.com', password: '00000000'));
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const SizedBox(
                width: double.infinity,
                child: Image(
                  image: AssetImage(secondaryBackground),
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DefaultTitle(),
                      Text(
                        "Welcome , please select road",
                        style: TextStyle(
                            fontFamily: fontFamily2, fontSize: defaultFontSize),
                      ),
                      const SizedBox20(),
                      FutureBuilder(
                        future: dataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return SelectRoadDropdownButton(
                                itemsList: snapshot.data ?? []);
                          } else {
                            return const Center(
                                child: Loading(),);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 220,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (selectedRoad != null) {
                              var getRoadCubit =
                                  BlocProvider.of<GetRoadCubit>(context);
                              log('=================================UI: Requesting road information for $selectedRoad');

                              getRoadCubit.getRoad(roadName: selectedRoad!);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserNavBar(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a road'),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 118,
                            height: 40,
                            decoration: BoxDecoration(
                              color: ColorManager.lightPrimary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Row(
                              children: [
                                Text(
                                  "Go",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
