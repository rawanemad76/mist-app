import 'package:flutter/material.dart';

class TapContainer extends StatelessWidget {
  const TapContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
    );
  }
}
