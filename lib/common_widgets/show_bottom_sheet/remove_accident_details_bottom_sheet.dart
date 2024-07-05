import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/sizedbox10.dart';
import 'package:mist_app/common_widgets/containers/tab_container.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/model/operations/coordinator_operations.dart';

import '../../location/map_shared_page.dart';
import '../../view/common_view/accident_view.dart';

class RemoveAccidentDetailsBottomSheet extends StatelessWidget {
  final String reportId;
  const RemoveAccidentDetailsBottomSheet({required this.reportId, super.key});

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
                  GestureDetector(
                    onTap: () async {
                      final msg = await CoordinatorOperations.deleteReport(
                          reportId: reportId);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(msg ?? 'Removed Successfully')));
                      Navigator.pop(context);
                    },
                    child: Text(
                      " Remove",
                      style: TextStyle(fontFamily: fontFamily1),
                    ),
                  ),
                ],
              ),
              const SizedBox10(),
              CustomButton(
                text: "open location",
                onTap: () {
                  if (sharedLat != 0 && sharedLong != 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapShared(
                          initialLocation: LatLng(sharedLat, sharedLong),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No location shared yet.')));
                  }
                },
              ),
              const SizedBox10(),
              CustomButton(
                  text: "Remove",
                  onTap: () async {
                    await CoordinatorOperations.deleteReport(reportId: reportId);
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
