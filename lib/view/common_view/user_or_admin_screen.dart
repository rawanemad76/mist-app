import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/images/custom_images.dart';
import 'package:mist_app/common_widgets/texts/default_title.dart';
import 'package:mist_app/constants/sizes.dart';

import '../coordinator_view/coordinator_nav_bar.dart';
import '../user_view/select_road.dart';

class UserOrAdminScreen extends StatelessWidget {
  const UserOrAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const SizedBox(
                width: double.infinity,
                child: Image(
                  image: AssetImage(secondaryBackground),
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const DefaultTitle(),
                    const Spacer(),
                    CustomButton(
                      text: "User",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectRoad(),
                          ),
                        );
                      },
                      width: 155,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: "co-ordinator",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CoordinatorNavBar(),
                          ),
                        );
                      },
                      width: 155,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: "Admin",
                      onTap: () {},
                      width: 155,
                    ),
                    const Spacer(
                      flex: 3,
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
