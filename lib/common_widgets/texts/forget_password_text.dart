import 'package:flutter/material.dart';
import 'package:mist_app/constants/fonts.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text("Forgot Password ?",style: TextStyle(fontSize: 20,fontFamily: fontFamily2),),
        Text("Don’t worry about your account ",style: TextStyle(fontSize: 13,fontFamily: fontFamily2),),
      ],
    );
  }
}
