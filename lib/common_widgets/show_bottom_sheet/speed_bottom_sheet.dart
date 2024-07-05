import 'package:flutter/cupertino.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/sizedbox10.dart';
import 'package:mist_app/common_widgets/containers/tab_container.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/model/operations/coordinator_operations.dart';

String? maxSpeed;
String? recommendedSpeed;

class SpeedBottomSheet extends StatefulWidget {
  const SpeedBottomSheet({super.key});

  @override
  State<SpeedBottomSheet> createState() => _SpeedBottomSheetState();
}

class _SpeedBottomSheetState extends State<SpeedBottomSheet> {
  final _key = GlobalKey<FormState>();
  int? recSpeed;
  int? maxSpeed;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Padding(
       padding:mediaQueryData.viewInsets,

      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            child: Column(
              children: [
                const TapContainer(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      " Edit Speed",
                      style: TextStyle(fontFamily: fontFamily1),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  hintText: "  max speed",
                  keyboardType: TextInputType.phone,
                  onChange: (value) {
                    maxSpeed = int.tryParse(value);
                  },
                ),
                const SizedBox10(),
                CustomTextField(
                  hintText: "  recommended speed",
                  keyboardType: TextInputType.phone,
                  onChange: (value) {
                    recSpeed = int.tryParse(value);
                  },
                ),
                const SizedBox10(),
                CustomButton(
                    text: "Done",
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        await CoordinatorOperations.setSpeed(
                            recSpeed: recSpeed!, maxSpeed: maxSpeed);
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
