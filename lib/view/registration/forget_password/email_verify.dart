import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/texts/forget_password_text.dart';
import 'package:mist_app/common_widgets/texts/mist_lemon_text.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/view/registration/login_screen.dart';

class EmailVerify extends StatelessWidget {
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                  child: Column(
                    children: [
                      const SizedBox20(),
                      const SizedBox20(),
                      const Row(
                        children: [
                          MistLemonText(),
                        ],
                      ),
                      const SizedBox20(),
                      const Row(
                        children: [
                          ForgetPasswordText(),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      const Row(
                        children: [
                          Spacer(),
                          CustomTextField(
                            hintText: "",
                            radius: 10,
                            width: 60,
                            keyboardType: TextInputType.phone,
                          ),
                          Spacer(),
                          CustomTextField(
                            hintText: "",
                            radius: 10,
                            width: 60,
                            keyboardType: TextInputType.phone,
                          ),
                          Spacer(),
                          CustomTextField(
                            hintText: "",
                            radius: 10,
                            width: 60,
                            keyboardType: TextInputType.phone,
                          ),
                          Spacer(),
                          CustomTextField(
                            hintText: "",
                            radius: 10,
                            width: 60,
                            keyboardType: TextInputType.phone,
                          ),
                          Spacer(),
                        ],
                      ),
                      const SizedBox20(),
                      Text(
                        "check your mail to confirm",
                        style: TextStyle(
                            fontFamily: fontFamily2, fontSize: defaultFontSize),
                      ),
                      Text(
                        "mohamed304.m@gmail.com",
                        style: TextStyle(fontFamily: fontFamily2, fontSize: 11),
                      ),
                      const SizedBox(
                        height: 180,
                      ),
                      CustomButton(
                          text: "Next",
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          }),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
