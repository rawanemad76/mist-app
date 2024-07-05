import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/texts/forget_password_text.dart';
import 'package:mist_app/common_widgets/texts/mist_lemon_text.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/auth/auth_services.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String oldPassword = '';
    String newPassword = '';
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
                    key: _key,
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
                        const SizedBox20(),
                        const SizedBox20(),
                        const SizedBox20(),
                        Row(
                          children: [
                            Text(
                              "Reset Password",
                              style: TextStyle(
                                  fontSize: defaultFontSize,
                                  fontFamily: fontFamily1),
                            ),
                          ],
                        ),
                        const SizedBox20(),
                        CustomTextField(
                          hintText: "  Old Password",
                          onChange: (value) {
                            oldPassword = value.trim();
                          },
                          obscureText: true,
                          validator: (data) {
                            if (data != null && data.length > 7) {
                              return null;
                            } else {
                              return 'password must be at least 8 characters';
                            }
                          },
                        ),
                        const SizedBox20(),
                        CustomTextField(
                          hintText: "  New Password",
                          onChange: (value) {
                            newPassword = value.trim();
                          },
                          obscureText: true,
                          validator: (data) {
                            if (data != null && data.length > 7) {
                              return null;
                            } else {
                              return 'password must be at least 8 characters';
                            }
                          },
                        ),
                        const SizedBox20(),
                        CustomTextField(
                            hintText: "  Confirm Password",
                            obscureText: true,
                            validator: (data) {
                              bool validpass2 = (data == newPassword);
                              if (validpass2) {
                                return null;
                              } else {
                                return 'passwords don\'t match';
                              }
                            }),
                        const SizedBox20(),
                        CustomButton(
                            text: "Done",
                            onTap: () async {
                              if (_key.currentState!.validate()) {
                                try {
                                  await AuthServices.resetPassword(
                                      oldPassword: oldPassword,
                                      newPassword: newPassword);
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                }
                              }
                            }),
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
