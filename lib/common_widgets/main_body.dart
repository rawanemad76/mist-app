// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mist_app/common_widgets/containers/accident_continer.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/strings.dart';
import 'package:mist_app/home_view_cubit/get_road_cubit/get_road_cubit.dart';
import 'package:mist_app/home_view_cubit/get_road_cubit/get_road_status.dart';
import 'package:mist_app/home_view_cubit/status/road_details_container.dart';
import 'package:mist_app/common_widgets/containers/custom_container.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/operations/data_models/notification_data_model.dart';
import 'package:mist_app/model/operations/data_models/report_data_model.dart';
import '../constants/colors.dart';

class MainBody extends StatelessWidget {
  final String currentRoad;
  final String maxSpeed;
  final String recommendSpeed;
  final NotificationDataModel? notification;
  final List<ReportDataMdoel> reports;
  final bool isOpen;
  VoidCallback? onTapNotification;
  VoidCallback? onTapReport;

  MainBody({
    super.key,
    required this.currentRoad,
    required this.maxSpeed,
    required this.recommendSpeed,
    required this.reports,
    required this.notification,
    required this.isOpen,
    this.onTapNotification,
    this.onTapReport,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          currentRoad,
          style: TextStyle(fontSize: statusSize, fontFamily: fontFamily2),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          isOpen ? 'Open' : 'Closed',
          style: TextStyle(
              fontSize: statusSize,
              fontFamily: fontFamily2,
              color: isOpen ? ColorManager.statusText : Colors.red),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Column(
              children: [
                Text(
                  "Max speed",
                  style:
                      TextStyle(fontSize: speedSize, fontFamily: fontFamily2),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  maxSpeed,
                  style: TextStyle(
                      fontSize: speedValSize,
                      fontFamily: fontFamily2,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  "Recommended",
                  style:
                      TextStyle(fontSize: speedSize, fontFamily: fontFamily2),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  recommendSpeed,
                  style: TextStyle(
                    fontSize: speedValSize,
                    fontFamily: fontFamily2,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.bottomNavColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Center(
            child: Text(
          "kmh",
          style: TextStyle(fontFamily: fontFamily2, fontSize: defaultFontSize),
        )),
        const SizedBox(
          height: 15,
        ),
        BlocBuilder<GetRoadCubit, RoadStates>(
          builder: (context, state) {
            if (state is RoadInitialState) {
              context.read<GetRoadCubit>().getRoad(roadName: selectedRoad!);
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primaryColor,
                ),
              );
            } else if (state is RoadLoadedState) {
              return const RoadDetailsContainer();
            } else {
              return const Center(
                  child: Text(
                "There was an error",
                style: TextStyle(fontSize: 30),
              ));
            }
          },
        ),

        const SizedBox(
          height: 15,
        ),
        CustomContainer(
          title: notification == null ? '' : notification!.title,
          statusRoad: notification == null ? '' : notification!.content,
          onTap: onTapNotification,
        ),
        const SizedBox(height: 15),
        // accident
        reports.isEmpty
            ? Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 1),
                      blurRadius: 3,
                      spreadRadius: 1,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'There are no Accidents\non this Road',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : AccidentDetailsContainer(
                image: reports.isNotEmpty ? reports[0].imgUrl : null,
                accidentDetails: reports.isNotEmpty ? reports[0].details : '',
                date: reports.isNotEmpty
                    ? dateFormatter.format(reports[0].time).toString()
                    : '',
                onTap: onTapReport,
              ),
        // : const SizedBox.shrink(),
        const SizedBox20(),
      ],
    );
  }
}
