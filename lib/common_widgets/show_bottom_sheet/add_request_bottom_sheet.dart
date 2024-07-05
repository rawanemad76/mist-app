import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/buttons/icon_button.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/sizedbox10.dart';
import 'package:mist_app/common_widgets/containers/tab_container.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/location/location_sharing_screen.dart';
import 'package:mist_app/model/operations/user_operation.dart';

class AddRequestBottomSheet extends StatefulWidget {
  final Function(LatLng) onLocationShared;
  final Function onRequestAdded;
  const AddRequestBottomSheet({super.key, required this.onLocationShared, required this.onRequestAdded});

  @override
  State<AddRequestBottomSheet> createState() => _AddRequestBottomSheetState();
}

class _AddRequestBottomSheetState extends State<AddRequestBottomSheet> {
  final _key = GlobalKey<FormState>();
  late String contactInf;
  late String details;
  bool onTap =false;
  LatLng? sharedLocation;


  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding:mediaQueryData.viewInsets,
      child: Form(
        key: _key,
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
                      " Add request",
                      style: TextStyle(fontFamily: fontFamily1),
                    ),
                  ],
                ),
                const SizedBox10(),
                CustomTextField(
                  keyboardType: TextInputType.phone,
                  hintText: "  Contact Inf",
                  radius: 20,
                  onChange: (value) {
                    contactInf = value;
                  },
                  validator: (data) {
                    final regex = RegExp(r'^(?:[+0]2)?[0-9]{11}$');
                    if (regex.hasMatch(data!)) {
                      return null;
                    } else {
                      return 'please enter a valid phone number';
                    }
                  },
                ),
                const SizedBox10(),
                CustomTextField(
                  hintText: "  Details",
                  maxLines: 3,
                  radius: 20,
                  onChange: (value) {
                    details = value;
                  },
                ),
                const SizedBox10(),
                ButtonWithIcon(
                    text: "Share Location",
                    icon: onTap?const Icon(Icons.check):const Icon(Icons.share_location_rounded),
                  onTap: () async {
                    Position position = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    double latitude = position.latitude;
                    double longitude = position.longitude;
                    LatLng location = LatLng(latitude, longitude);


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationSharingScreen(
                          initialLocation: location,
                        ),
                      ),
                    );
                    setState(() {
                      sharedLocation = location;
                      onTap = true;
                    });
                  },
                ),
                const SizedBox10(),
                CustomButton(
                    text: "Add",
                    onTap: () async {


                      if (_key.currentState!.validate()) {
                        await UserOperations.postAssistance(
                          contactInfo: contactInf,
                          details: details,
                          latitude: 0,
                          longitude: 0,
                        );
                        if (!context.mounted) return;
                        widget.onRequestAdded;
                        Navigator.pop(context,true);
                      }
                      // setState(() {
                      //   UserOperations.postAssistance(contactInfo: contactInf, details: details, latitude: 0, longitude: 0);
                      // });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> _postAssistance() async {
  //   // get current location (latitude: 33, longitude: 44 for example)
  //   double latitude = 10;
  //   double longitude = 10;

  //   // get details from TextField
  //   const details = 'example details';

  //   // get contact from TextField
  //   const contact = '01251211545';

  //   // when data is collected use this function to post assistance
  //   await UserOperations.postAssistance(
  //     contactInfo: contact,
  //     details: details,
  //     latitude: latitude,
  //     longitude: longitude,
  //   );
  //   return;
  // }
}
