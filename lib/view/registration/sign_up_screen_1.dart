import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/texts/mist_lemon_text.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/colors.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/auth/models/sign_up_data_model.dart';
import 'package:mist_app/view/registration/login_screen.dart';
import 'package:mist_app/view/registration/sign_up_screen_2.dart';

class SignUpScreen1 extends StatefulWidget {
  const SignUpScreen1({super.key});

  @override
  State<SignUpScreen1> createState() => _SignUpScreen1State();
}

class _SignUpScreen1State extends State<SignUpScreen1> {
  final _formKey = GlobalKey<FormState>();
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
                  child: Form(
                    key: _formKey,
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
                        const SizedBox20(),
                        Text(
                          "Welcome On Mist",
                          style: TextStyle(
                              fontSize: defaultFontSize,
                              fontFamily: fontFamily1),
                        ),
                        const SizedBox20(),
                        const SizedBox20(),
                        Row(
                          children: [
                            Text(
                              "SignUp",
                              style: TextStyle(
                                  fontSize: defaultFontSize,
                                  fontFamily: fontFamily1),
                            ),
                          ],
                        ),
                        const SizedBox20(),
                        CustomTextField(
                          hintText: "  First name",
                          onChange: (value) {signUpDataModel.fname = value.trim();},),
                        const SizedBox20(),
                        CustomTextField(
                          hintText: "  Last name",
                          onChange: (value) {signUpDataModel.lname = value.trim();},),
                        const SizedBox20(),
                        CustomTextField(
                          hintText: "  National ID",
                          keyboardType: TextInputType.phone,
                          onChange: (value) {signUpDataModel.nid = value.trim();},
                          validator: (data) {
                            if (data != null &&
                                int.tryParse(data) != null &&
                                data.length == 14) {
                              return null;
                            } else {return 'please enter a valid national id';}},),
                        const SizedBox20(),
                        CustomTextField(
                          hintText: "  Phone Number",
                          keyboardType: TextInputType.phone,
                          onChange: (value) {
                            signUpDataModel.phone = value.trim();},
                          validator: (data) {
                            if (data != null &&
                                int.tryParse(data) != null &&
                                data.length == 11) {
                              return null;
                            } else {return 'please enter a valid phone number';
                            }
                          },
                        ),
                        const SizedBox20(),
                        CustomButton(
                            text: "Next",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen2()));
                              }
                            }),
                        const SizedBox20(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                  fontSize: defaultFontSize,
                                  fontFamily: fontFamily2),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: defaultFontSize,
                                    fontFamily: fontFamily1,
                                    color: ColorManager.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
