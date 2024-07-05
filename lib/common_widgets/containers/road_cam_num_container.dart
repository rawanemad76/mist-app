// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/containers/custom_decoration.dart';
import 'package:mist_app/common_widgets/sizedbox10.dart';
import 'package:mist_app/constants/colors.dart';

import '../../my_flutter_app_icons.dart';

class RoadCamNumContainer extends StatelessWidget {
  RoadCamNumContainer({
    super.key,
    required this.name,
    required this.camNum,
  });

  String name;
  int camNum;

  @override
  Widget build(BuildContext context) {
    return CustomDecoration(
      height: 158,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Icon(MyFlutterApp.road),
              ],
            ),
            const SizedBox10(),
            Text(
              "$camNum",
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.primaryColor),
            ),
            const Text(
              "CamNum",
              style: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
