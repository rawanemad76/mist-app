import 'package:flutter/material.dart';
import 'package:mist_app/constants/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorManager.primaryColor,
      ),
    ) ;
  }
}
