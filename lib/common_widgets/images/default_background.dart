import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/images/custom_images.dart';

class DefaultBackground extends StatelessWidget {
  const DefaultBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        primaryBackground,
        fit: BoxFit.cover,
      ),
    );
  }
}
