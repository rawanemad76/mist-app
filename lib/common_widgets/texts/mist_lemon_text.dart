import 'package:flutter/material.dart';
import '../../constants/fonts.dart';

class MistLemonText extends StatelessWidget {
  const MistLemonText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Mist",
      style: TextStyle(
        fontSize: 65,
        fontFamily: fontFamily1,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
