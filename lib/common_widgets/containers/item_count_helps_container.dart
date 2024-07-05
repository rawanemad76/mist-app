// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/containers/custom_decoration.dart';
import 'package:mist_app/constants/colors.dart';

class ItemsCountHelpsContainer extends StatelessWidget {
  ItemsCountHelpsContainer(
      {super.key,
        required this.name,
        required this.totalCount,
        required this.resolvedCount,
        required this.unResolvedCount,
        required this.iconName,
        this.onPressed,
        this.iconPressed});

  String name;
  int totalCount;
  int resolvedCount;
  int unResolvedCount;
  Widget iconName;
  Widget? iconPressed;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomDecoration(
        height: 180,
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

              Row(
                children: [
                  const Text(
                    " Total :",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    " $totalCount",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.primaryColor),
                  ),
                ],
              ),

              Row(
                children: [
                  const Text(
                    " Resolved :",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    " $resolvedCount",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.primaryColor),
                  ),
                ],
              ),

              Row(
                children: [
                  const Text(
                    " UnResolved :",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    " $unResolvedCount",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.primaryColor),
                  ),
                ],
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
