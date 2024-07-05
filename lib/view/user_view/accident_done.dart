import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/show_custom_toast.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/auth/models/profile_data_model.dart';
import 'package:mist_app/view/coordinator_view/coordinator_nav_bar.dart';
import 'package:mist_app/view/user_view/user_nav_bar.dart';

class AccidentDone extends StatelessWidget {
  const AccidentDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Column(
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Image.asset("assets/images/done.png"),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomButton(
                      text: "Done",
                      onTap: () {

                        if(humRole==2){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CoordinatorNavBar(),
                            ),
                          );
                        }else if(humRole==3){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserNavBar(),
                            ),
                          );
                        }

                        showCustomToast(context);
                      }),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
