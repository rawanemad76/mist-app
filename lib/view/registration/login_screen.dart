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
import 'package:mist_app/constants/strings.dart';
import 'package:mist_app/model/auth/auth_services.dart';
import 'package:mist_app/model/auth/models/login_data_model.dart';
import 'package:mist_app/view/admin_view/admin_home_screen.dart';
import 'package:mist_app/view/coordinator_view/coordinator_nav_bar.dart';
import 'package:mist_app/view/registration/forget_password/forget_password_screen.dart';
import 'package:mist_app/view/user_view/select_road.dart';
import 'sign_up_screen_1.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginDataModel data = LoginDataModel();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
                            Text(
                              "Welcome Back !",
                              style: TextStyle(
                                  fontSize: defaultFontSize,
                                  fontFamily: fontFamily1),
                            ),
                            const SizedBox20(),
                            const Image(
                              image:
                                  AssetImage("assets/images/log in image.png"),
                            ),
                            const SizedBox20(),
                            Row(
                              children: [
                                Text(
                                  "LogIn",
                                  style: TextStyle(
                                      fontSize: defaultFontSize,
                                      fontFamily: fontFamily1),
                                ),
                              ],
                            ),
                            const SizedBox20(),
                            CustomTextField(
                              hintText: "  Email",
                              keyboardType: TextInputType.emailAddress,
                              onChange: (value) {
                                data.email = value.trim();
                              },
                              validator: CustomTextField.emailValidator,
                            ),
                            const SizedBox20(),
                            CustomTextField(
                              hintText: "  password",
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              onChange: (value) {
                                data.password = value.trim();
                              },
                            ),
                            const SizedBox20(),
                            CustomButton(
                                text: "LogIn",
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setLoading(true);
                                    try {
                                      final profile =
                                          await AuthServices.logIn(data);
                                      setLoading(false);

                                      debugPrint('@@@ role: ${profile.role}');

                                      Widget? targetScreen;
                                      switch (profile.role) {
                                        case 1:
                                          targetScreen =
                                              const AdminHomeScreen();
                                          break;
                                        case 2:
                                          targetScreen =
                                              const CoordinatorNavBar();
                                          break;
                                        case 3:
                                          targetScreen = const SelectRoad();
                                          break;
                                      }
                                      if (!context.mounted) return;
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                targetScreen!),
                                        (route) => false,
                                      );
                                    } catch (e) {
                                      setLoading(false);
                                      final SnackBar s;
                                      if (e.toString() ==
                                          emailNotVerifiedError) {
                                        s = SnackBar(
                                          content:
                                              const Text('verify your email'),
                                          action: SnackBarAction(
                                              label: 'resend email',
                                              onPressed: () => AuthServices
                                                  .resendVerificationEmail()),
                                        );
                                      } else {
                                        s = SnackBar(
                                            content: Text(e.toString()));
                                      }

                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(s);
                                    }
                                  }
                                }),
                            const SizedBox20(),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgetPasswordScreen()));
                                  },
                                  child: Text(
                                    "Forget Password!",
                                    style: TextStyle(
                                      fontSize: defaultFontSize,
                                      fontFamily: fontFamily2,
                                      fontWeight: FontWeight.bold,
                                      color: ColorManager.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox20(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don’t have an account?",
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
                                                const SignUpScreen1()));
                                  },
                                  child: Text(
                                    "SignUp",
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
                    ),),),],),),),
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
    );
  }

  setLoading(bool l) {
    setState(() {
      isLoading = l;
    });
  }
}
