// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/containers/custom_decoration.dart';
import 'package:mist_app/common_widgets/sizedbox10.dart';
import 'package:mist_app/constants/colors.dart';

class ItemsCountDetailsContainer extends StatelessWidget {
  ItemsCountDetailsContainer(
      {super.key,
      required this.name,
      required this.count,
      required this.iconName,
      this.onPressed,
      this.iconPressed});

  String name;
  int count;
  Widget iconName;
  Widget? iconPressed;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomDecoration(
        height: 140,
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
                  iconName,
                ],
              ),
              const SizedBox10(),
              Text(
                "$count",
                style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primaryColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  iconPressed!,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
