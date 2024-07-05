// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/sizedbox10.dart';
import 'package:mist_app/common_widgets/containers/tab_container.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/model/operations/coordinator_operations.dart';

class AddOrDeleteNotificationBottomSheet extends StatefulWidget {
  const AddOrDeleteNotificationBottomSheet({super.key});

  @override
  State<AddOrDeleteNotificationBottomSheet> createState() =>
      _AddOrDeleteNotificationBottomSheetState();
}

class _AddOrDeleteNotificationBottomSheetState
    extends State<AddOrDeleteNotificationBottomSheet> {
  final _key = GlobalKey<FormState>();
  String title = '';
  String content = '';

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
            child: Column(
              children: [
                const TapContainer(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      " Edit notification",
                      style: TextStyle(fontFamily: fontFamily1),
                    ),
                  ],
                ),
                const SizedBox10(),
                CustomTextField(
                  hintText: "  Title",
                  keyboardType: TextInputType.text,
                  onChange: (value) {
                    title = value;
                  },
                ),
                const SizedBox10(),
                CustomTextField(
                  hintText: "  Content",
                  keyboardType: TextInputType.text,
                  onChange: (value) {
                    content = value;
                  },
                ),
                const SizedBox10(),
                CustomButton(
                    text: "Update",
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        await CoordinatorOperations.setNotification(
                            title: title, content: content);

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
