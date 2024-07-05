import 'package:flutter/cupertino.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/sizedbox10.dart';
import 'package:mist_app/common_widgets/containers/tab_container.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/model/operations/coordinator_operations.dart';
import 'package:mist_app/model/operations/data_models/notification_data_model.dart';

class EditNotificationBottomSheet extends StatelessWidget {
  final NotificationDataModel noti;
  const EditNotificationBottomSheet({required this.noti, super.key});

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
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    " Remove notification",
                    style: TextStyle(fontFamily: fontFamily1),
                  ),
                ],
              ),
              const SizedBox10(),
              CustomTextField(
                readOnly: true,
                hintText: noti.title,
                radius: 20,
              ),
              const SizedBox10(),
              CustomTextField(
                readOnly: true,
                hintText: noti.content,
                maxLines: 3,
                radius: 20,
              ),
              const SizedBox10(),
              // CustomButton(text: "Add", onTap: () {}),
              // const SizedBox10(),
              CustomButton(
                  text: "Remove",
                  onTap: () async {
                    await CoordinatorOperations.removeNotification();
                    if (!context.mounted) return;
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
