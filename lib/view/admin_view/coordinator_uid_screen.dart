import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/operations/admin_operations.dart';
import '../../constants/fonts.dart';

class CoordinatorUID extends StatefulWidget {
  const CoordinatorUID({super.key});

  @override
  State<CoordinatorUID> createState() => _CoordinatorUIDState();
}

class _CoordinatorUIDState extends State<CoordinatorUID> {
  final _key = GlobalKey<FormState>();
  String? userEmail;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: SizedBox(
                width: double.infinity,
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          InkWell(
                            child: const Icon(
                              Icons.arrow_back_ios_sharp,
                              size: 15,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            " Email",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: fontFamily1),
                          ),
                        ],
                      ),
                      const SizedBox20(),
                      CustomTextField(
                        hintText: ' Email',
                        keyboardType: TextInputType.emailAddress,
                        radius: 15,
                        onChange: (value) => userEmail = value,
                        validator: CustomTextField.emailValidator,
                      ),
                      const SizedBox20(),
                      CustomButton(
                          text: "Done",
                          isLoading: isLoading,
                          onTap: isLoading
                              ? null
                              : () async {
                                  if (_key.currentState!.validate()) {
                                    setState(() => isLoading = true);
                                    try {
                                      await AdminOperations.addCoForRoad(
                                          userEmail: userEmail!,
                                          roadId: selectedRoadId!);
                                      if (!context.mounted) return;
                                      Navigator.of(context).pop();
                                    } catch (e) {
                                      setState(() => isLoading = true);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(e.toString())));
                                    }
                                  }
                                }),
                      const Spacer(
                        flex: 4,
                      ),
                    ],
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
