import 'package:flutter/cupertino.dart';

import '../../constants/fonts.dart';
import '../../constants/sizes.dart';
import '../sizedbox10.dart';

class UserTitle extends StatelessWidget {
  const UserTitle({super.key,required this.title,required this.roadName});

  final String title;
  final String roadName;


  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: speedSize, fontFamily: fontFamily2,fontWeight: FontWeight.w900),
        ),
        const SizedBox10(),
        Text(
          roadName,
          style: TextStyle(
              fontSize: defaultFontSize, fontFamily: fontFamily2),
        ),
        const SizedBox(
          height: 45,
        ),
      ],
    );
  }
}
