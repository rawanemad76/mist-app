import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/images/custom_images.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/loading.dart';
import 'package:mist_app/common_widgets/sizedbox10.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/common_widgets/texts/custom_text_field.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/model/auth/auth_services.dart';
import 'package:mist_app/model/auth/models/profile_data_model.dart';
import 'package:mist_app/model/operations/user_operation.dart';
import 'package:mist_app/view/registration/forget_password/reset_password.dart';
import 'package:mist_app/view/registration/login_screen.dart';


class AdminProfileView extends StatefulWidget {
  const AdminProfileView({super.key});

  @override
  State<AdminProfileView> createState() => _AdminProfileViewState();
}

class _AdminProfileViewState extends State<AdminProfileView> {
  Uint8List? _image;
  File? _imagePicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: FutureBuilder(
                future: AuthServices.getCurrentProfile(shouldLoad: true),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _buildBody(snapshot.data!);
                  } else {
                    return const Center(child:Loading());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(ProfileDataModel profile) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 90),
            Stack(
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                          spreadRadius: 1,

                          //spreadRadius: 10,
                        ),
                      ]),
                  child: _image != null
                      ? CircleAvatar(
                    maxRadius: 50,
                    backgroundImage: MemoryImage(_image!),
                  )
                      : profile.picUrl != null
                      ? CircleAvatar(
                    maxRadius: 50,
                    backgroundImage: NetworkImage(profile.picUrl!),
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(profileImage),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: InkWell(
                      onTap: () {
                        pickImage();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(0, 1),
                                blurRadius: 3,
                                spreadRadius: 1,

                                //spreadRadius: 10,
                              ),
                            ]),
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox10(),
            Text(
              '${profile.fname} ${profile.lname}',
              style: TextStyle(fontSize: 24, fontFamily: fontFamily1),
            ),
            // Text(
            //   profile.email!,
            //   style: const TextStyle(fontSize: 20),
            // ),
            const SizedBox20(),
            CustomTextField(
              readOnly: true,
              hintText: profile.email!,
              radius: 15,
            ),
            const SizedBox20(),
            CustomTextField(
              readOnly: true,
              hintText: profile.nid!,
              radius: 15,
            ),
            const SizedBox20(),
            CustomButton(
                text: "Reset Password",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPassword()),
                  );
                }),
            const SizedBox20(),
            CustomButton(
                color: const Color.fromARGB(255, 173, 74, 66),
                text: "Log Out",
                onTap: () async {
                  try {
                    await AuthServices.signOut();
                    if (!mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                          (route) => false,
                    );
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _imagePicked = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    UserOperations.updateProfilePic(File(returnImage.path));
  }
}
