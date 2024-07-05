import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/texts/mist_lemon_text.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/colors.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/auth/auth_services.dart';
import 'package:mist_app/model/auth/models/sign_up_data_model.dart';
import 'package:mist_app/view/registration/forget_password/email_verify_2.dart';
import 'package:mist_app/view/registration/login_screen.dart';

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({super.key});

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              const DefaultBackground(),
              SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: paddingHorizontal),
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
                            hintText: "  Email",
                            onChange: (value) {
                              signUpDataModel.email = value.trim();
                            },
                            validator: CustomTextField.emailValidator,
                          ),
                          const SizedBox20(),
                          CustomTextField(
                            hintText: "  Password",
                            onChange: (value) {
                              signUpDataModel.password = value.trim();
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
                            hintText: "  Confirm password",
                            obscureText: true,
                            validator: (data) {
                              bool validpass2 =
                                  (data == signUpDataModel.password);
                              if (validpass2) {
                                return null;
                              } else {
                                return 'passwords don\'t match';
                              }
                            },
                          ),
                          const SizedBox20(),
                          Row(
                            children: [
                              CustomButton(
                                text: "Back",
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                width: 155,
                              ),
                              const Spacer(),
                              CustomButton(
                                text: "SignUP",
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setLoading(true);
                                    try {
                                      await AuthServices.signUp();
                                      setLoading(false);
                                      if (!context.mounted) return;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EmailVerify2(
                                                    email:
                                                        signUpDataModel.email!,
                                                    task: 'verification',
                                                  )));
                                    } catch (e) {
                                      setLoading(false);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(e.toString())));
                                    }
                                  }
                                },
                                width: 155,
                              ),
                            ],
                          ),
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
      ),
      isLoading ? _buildModal() : const SizedBox.shrink(),
    ]);
  }

  _buildModal() {
    return const Stack(
      children: [
        ModalBarrier(
          dismissible: false,
          color: Color.fromARGB(38, 0, 0, 0),
        ),
        Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: Loading(),
          ),
        ),
      ],
    );
  }

  setLoading(bool l) {
    setState(() {
      isLoading = l;
    });
  }
}
