import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mist_app/common_widgets/buttons/icon_button.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/sizedbox10.dart';
import 'package:mist_app/common_widgets/containers/tab_container.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/location/location_sharing_screen.dart';

class MoreInfoBottomSheet extends StatefulWidget {
  final String contactInfo;
  final String details;
  final LatLng location;
 // final VoidCallback onSolved;

   MoreInfoBottomSheet(
      {required this.location,this.contactInfo = '', this.details = '', super.key, });

  @override
  State<MoreInfoBottomSheet> createState() => _MoreInfoBottomSheetState();
}

class _MoreInfoBottomSheetState extends State<MoreInfoBottomSheet> {


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
                    " more Information",
                    style: TextStyle(fontFamily: fontFamily1),
                  ),
                ],
              ),
              const SizedBox10(),
              CustomTextField(
                hintText: widget.contactInfo,
                readOnly: true,
                radius: 20,
              ),
              const SizedBox10(),
              CustomTextField(
                hintText: widget.details,
                readOnly: true,
                maxLines: 3,
                radius: 20,
              ),
              const SizedBox10(),
              ButtonWithIcon(
                  text: "open Location",
                  icon: const Icon(Icons.check),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationSharingScreen(
                        initialLocation: widget.location,
                      ),
                    ),
                  );

                },
              ),
              const SizedBox10(),
              // CustomButton(text: ("Solved"), onTap: (){
              //   widget.onSolved();
              //   Navigator.pop(context);
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
