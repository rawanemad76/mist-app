import 'package:flutter/material.dart';
import 'package:mist_app/auth_wrapper.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/images/custom_images.dart';
import 'package:mist_app/common_widgets/texts/mist_lemon_text.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/view_model/get_started_view_model.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  final data = const GetStartedViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Image(
                image: AssetImage(getStartedBackground),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 3,
                    ),
                    const MistLemonText(),
                    const SizedBox(
                      height: 10,
                    ),
                    Image(
                      image: AssetImage(data.image),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      data.description,
                      style: TextStyle(fontSize: 16, fontFamily: fontFamily1),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    CustomButton(
                      text: data.buttonText,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AuthWrapper(),
                          ),
                        );
                      },
                    ),
                    const Spacer(
                      flex: 1,
                    ),
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
