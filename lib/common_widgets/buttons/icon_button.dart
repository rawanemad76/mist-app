// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mist_app/constants/fonts.dart';
import '../../constants/colors.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback? onTap;
  final double width;

  const ButtonWithIcon({
    super.key,
    required this.text,
    required this.onTap,
    this.width = double.infinity,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: onTap == null ? Colors.grey : ColorManager.primaryColor,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: fontFamily1,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 7,
              ),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
