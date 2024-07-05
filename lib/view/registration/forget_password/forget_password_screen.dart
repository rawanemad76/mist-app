import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/texts/forget_password_text.dart';
import 'package:mist_app/common_widgets/texts/mist_lemon_text.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/auth/auth_services.dart';
import 'package:mist_app/view/registration/forget_password/email_verify_2.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String email = '';
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
                      const SizedBox20(),
                      const SizedBox20(),
                      const SizedBox20(),
                      Row(
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                                fontSize: defaultFontSize,
                                fontFamily: fontFamily1),
                          ),
                        ],
                      ),
                      const SizedBox20(),
                      Form(
                        key: _formKey,
                        child: CustomTextField(
                          hintText: "  Enter email",
                          keyboardType: TextInputType.emailAddress,
                          onChange: (value) {
                            email = value;
                          },
                          validator: CustomTextField.emailValidator,
                        ),
                      ),
                      const SizedBox20(),
                      CustomButton(
                        text: "Next",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });

                            try {
                              await AuthServices.sendResetPasswordEmail(email);
                              setState(() {
                                isLoading = false;
                              });
                              if (!context.mounted) return;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EmailVerify2(
                                            email: email,
                                            task: 'password-reset',
                                          )));
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isLoading
                ? const ModalBarrier(
                    dismissible: false,
                    color: Color.fromARGB(38, 0, 0, 0),
                  )
                : const SizedBox.shrink(),
            isLoading
                ? const Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Loading(),),)
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
