import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/model/operations/admin_operations.dart';
import 'package:mist_app/model/operations/data_models/road_data_model.dart';
import '../containers/tab_container.dart';

String? roadStatus;

class AddRoadBottomSheet extends StatefulWidget {
  const AddRoadBottomSheet({super.key});

  @override
  State<AddRoadBottomSheet> createState() => _AddRoadBottomSheetState();
}

class _AddRoadBottomSheetState extends State<AddRoadBottomSheet> {
  final key = GlobalKey<FormState>();
  String name = '';
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding:mediaQueryData.viewInsets,
        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Container(
              margin:  const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
              child: Column(
                children: [
                  const TapContainer(),
                  const SizedBox20(),
                  Row(
                    children: [
                      Text(
                        "Add Road",
                        style: TextStyle(fontFamily: fontFamily1),
                      ),
                    ],
                  ),
                  const SizedBox20(),
                  CustomTextField(
                      hintText: " Road Name",
                      onChange: (value) {
                        name = value;
                      },
                      validator: (data) =>
                          data!.isEmpty ? 'road name is required' : null),
                  const SizedBox20(),
                  CustomButton(
                      text: "Done",
                      onTap: () async {
                        if (key.currentState!.validate()) {
                          final msg = await AdminOperations.addRoad(
                              RoadDataModel.empty(name));
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(msg ?? 'Road Added Successfully')));
                          if (msg == null) {
                            Navigator.pop(context);
                          }
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
