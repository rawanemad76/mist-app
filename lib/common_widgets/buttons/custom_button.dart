import 'package:flutter/material.dart';
import 'package:mist_app/constants/fonts.dart';
import '../../constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback? onTap;
  final double width;
  final Color color;

  const CustomButton({
    super.key,
    required this.text,
    this.isLoading = false,
    required this.onTap,
    Color? color,
    this.width = double.infinity,
  }) : color = color ?? ColorManager.primaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: onTap == null ? Colors.grey : color,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: fontFamily1,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
