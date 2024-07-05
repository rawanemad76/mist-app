import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/buttons/icon_button.dart';
import 'package:mist_app/common_widgets/dropdown_list/accident_type_drobdown_list.dart';
import 'package:mist_app/common_widgets/dropdown_list/select_road_drop_down_list.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/show_custom_toast.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/common_widgets/texts/user_title.dart';
import 'package:mist_app/model/operations/user_operation.dart';
import '../../constants/sizes.dart';
import '../../location/location_sharing_screen.dart';

double sharedLong = 0  ;
double sharedLat = 0  ;
class AccidentView extends StatefulWidget {
  const AccidentView({super.key});

  @override
  State<AccidentView> createState() => _AccidentViewState();
}

class _AccidentViewState extends State<AccidentView> {
  bool isLoading = false;
  String? type;
  String? details;
  Uint8List? _image;
  File? _imagePicked;
  double? latitude;
  double? longitude;
  bool onTap =false;
  String? _address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserTitle(
                        title: "Report an accident",
                        roadName: selectedRoad ?? "Current road"),
                    CustomTextField(
                      hintText: "  Type details here ......",
                      maxLines: 2,
                      radius: 10,
                      onChange: (value) {
                        details = value;
                      },
                    ),
                    const SizedBox20(),
                    ButtonWithIcon(
                        text: "Share Location",
                        icon: onPressedCheck? const Icon(Icons.check):const Icon(Icons.share_location_outlined),
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationSharingScreen(
                                initialLocation:
                                    LatLng(latitude ?? 0.0, longitude ?? 0.0),
                              ),
                            ),
                          );
                          if (result != null && result is LatLng) {
                            setState(() {
                              latitude = result.latitude;
                              longitude = result.longitude;
                            });
                            await _getAddressFromLatLng(result);
                          }
                          setState(() {
                            onTap = true;
                            sharedLat = latitude!;
                          });
                        }),
                    // _address != null
                    //     ? Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Text('Address: $_address'),
                    // )
                    //     : const SizedBox.shrink(),

                    const SizedBox20(),
                    ButtonWithIcon(
                        text: "Add image",
                        icon: const Icon(Icons.image),
                        onTap: () {
                          pickImage();
                        }),
                    const SizedBox20(),
                    _imagePicked != null
                        ? Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: FileImage(_imagePicked!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _imagePicked != null
                        ? const SizedBox20()
                        : const SizedBox.shrink(),
                    AccidentTypeDropdownButton(
                      onChange: (value) {
                        type = value;
                      },
                    ),
                    const SizedBox20(),
                    CustomButton(
                        text: "Done",
                        onTap: () async {
                          if (details != null && type != null) {
                            setLoading(true);
                            try {
                              await UserOperations.postReport(
                                  details: details!,
                                  longitude: longitude ?? 0,
                                  latitude: latitude ?? 0,
                                  type: type!,
                                  image: _imagePicked);
                              _imagePicked = null;
                              if (!context.mounted) return;
                             // Navigator.pop(context);
                              showCustomToast(context);
                              setLoading(false);
                            } catch (e) {
                              setLoading(false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('please enter data')));
                          }

                          print(latitude);
                          print(longitude);
                          print(
                              "================================================");

                         // showCustomToast(context);
                        }),
                  ],
                ),
              ),
            ),
            isLoading
                ? const ModalBarrier(
                    dismissible: false,
                    color: Color.fromARGB(38, 0, 0, 0),
                  )
                : const SizedBox.shrink(),
            isLoading
                ? const Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child:Loading()))
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    final returnImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (returnImage == null) return;
    setState(() {
      _imagePicked = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
  }

  setLoading(bool l) {
    setState(() {
      isLoading = l;
    });
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _address =
        "${place.street}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}";
      });
    } catch (e) {
      print(e);
    }
  }
}




