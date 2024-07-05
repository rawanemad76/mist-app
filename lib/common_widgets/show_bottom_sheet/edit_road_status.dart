import 'package:flutter/cupertino.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/model/operations/coordinator_operations.dart';

import '../containers/tab_container.dart';

String? roadStatus;

class EditRoadStatusBottomSheet extends StatefulWidget {
  const EditRoadStatusBottomSheet({super.key});

  @override
  State<EditRoadStatusBottomSheet> createState() =>
      _EditRoadStatusBottomSheetState();
}

class _EditRoadStatusBottomSheetState extends State<EditRoadStatusBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: Column(
            children: [
              const TapContainer(),
              const SizedBox20(),
              Row(
                children: [
                  Text(
                    "Open or Closed",
                    style: TextStyle(fontFamily: fontFamily1),
                  ),
                ],
              ),
              const SizedBox20(),
              CustomButton(
                  text: "Open",
                  onTap: () async {
                    await CoordinatorOperations.setClosed(isOpen: true);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  }),
              const SizedBox20(),
              CustomButton(
                  text: "Closed",
                  onTap: () async {
                    await CoordinatorOperations.setClosed(isOpen: false);
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
