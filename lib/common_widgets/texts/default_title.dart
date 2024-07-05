import 'package:flutter/material.dart';
import 'package:mist_app/constants/fonts.dart';

class DefaultTitle extends StatelessWidget {
  const DefaultTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 90,bottom: 80),
      child: SizedBox(
        width: double.infinity,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mist",
              style: TextStyle(fontSize: 36, fontFamily: fontFamily2),
            ),
            Text(
              "Smart Road Services",
              style: TextStyle(fontSize: 16, fontFamily: fontFamily2),
            ),
          ],
        ),
      ),
    );
  }
}
