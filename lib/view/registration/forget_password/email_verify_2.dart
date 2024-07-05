import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/texts/mist_lemon_text.dart';
import 'package:mist_app/common_widgets/show_custom_toast.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/view/registration/login_screen.dart';

class EmailVerify2 extends StatefulWidget {
  final String email;
  final String task;

  const EmailVerify2({
    required this.email,
    required this.task,
    super.key,
  });

  @override
  State<EmailVerify2> createState() => _EmailVerify2State();
}

class _EmailVerify2State extends State<EmailVerify2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Row(
                      children: [
                        MistLemonText(),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '${widget.task} link was sent to email',
                      style: TextStyle(fontFamily: fontFamily2, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.email,
                      style: TextStyle(
                          fontFamily: fontFamily2, fontSize: defaultFontSize),
                    ),
                    const SizedBox(height: 16),
                    widget.task == 'verification'
                        ? const SizedBox.shrink()
                        : Text(
                            'set new password and press done',
                            style: TextStyle(
                                fontFamily: fontFamily2, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                    const Spacer(),
                    CustomButton(
                        text: "Done",
                        onTap: () {
                          showCustomToast(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                        }),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
