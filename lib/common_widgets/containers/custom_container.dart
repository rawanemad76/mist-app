// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mist_app/constants/sizes.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final String statusRoad;
  final bool showHeader;
  double height;
  VoidCallback? onTap;

  CustomContainer({
    super.key,
    required this.title,
    required this.statusRoad,
    this.showHeader = true,
    this.height = 140,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 1,
              ),],
            borderRadius: BorderRadius.circular(15),),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      showHeader ? "notification : $title" : title,
                      style: TextStyle(fontSize: containerTextFont),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      statusRoad,
                      style: TextStyle(fontSize: containerTextFont),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
