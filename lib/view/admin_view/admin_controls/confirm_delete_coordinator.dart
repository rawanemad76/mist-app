import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/auth/models/profile_data_model.dart';
import 'package:mist_app/model/operations/admin_operations.dart';
import 'package:mist_app/view/admin_view/admin_controls/add_coordinator.dart';

class ConfirmDeleteCoordinator extends StatefulWidget {
  final ProfileDataModel co;
  const ConfirmDeleteCoordinator({required this.co, super.key});

  @override
  State<ConfirmDeleteCoordinator> createState() =>
      _ConfirmDeleteCoordinatorState();
}

class _ConfirmDeleteCoordinatorState extends State<ConfirmDeleteCoordinator> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        "This Coordinator will be Removed",
                        style: TextStyle(
                            fontSize: defaultFontSize, fontFamily: fontFamily1),
                      ),
                    ],
                  ),
                  const SizedBox20(),
                  CoWidget(co: widget.co, showRemoveIcon: false),
                  const SizedBox20(),
                  CustomButton(
                      text: "confirm",
                      isLoading: isLoading,
                      onTap: isLoading
                          ? null
                          : () async {
                              setState(() => isLoading = true);
                              try {
                                await AdminOperations.removeCoFromRoad(
                                    userEmail: widget.co.email!);
                              } catch (e) {
                                setState(() => isLoading = true);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())));
                              }
                              if (!context.mounted) return;
                              Navigator.pop(context);
                            }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
