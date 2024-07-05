import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/buttons/icon_button.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/sizedbox10.dart';
import 'package:mist_app/common_widgets/containers/tab_container.dart';
import 'package:mist_app/constants/fonts.dart';

class EditAddedRequestBottomSheet extends StatelessWidget {
  const EditAddedRequestBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding:mediaQueryData.viewInsets,
      child: SingleChildScrollView(
        child: Container(
          margin:  const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: Column(
            children: [
              const TapContainer(),
              const SizedBox(height: 15,),
              Row(
                children: [
                  Text(
                    " Edit request",
                    style: TextStyle(fontFamily: fontFamily1),
                  ),
                ],
              ),
              const SizedBox10(),
              const CustomTextField(
                hintText: "  Contact Inf",
                radius: 20,
              ),
              const SizedBox10(),
              const CustomTextField(
                hintText: "  Details",
                maxLines: 3,
                radius: 20,

              ),
              const SizedBox10(),
              ButtonWithIcon(
                  text: "Share Location",
                  icon:  const Icon(Icons.location_pin),
                  onTap: () {

                  }),
              const SizedBox10(),
              CustomButton(text: "Edit", onTap: (){}),
              const SizedBox10(),
              CustomButton(text: "Mark done", onTap: (){}),
            ],
          ),
        ),
      ),
    );
  }
}
