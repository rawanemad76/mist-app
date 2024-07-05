import 'package:flutter/material.dart';
import 'package:mist_app/common_widgets/buttons/custom_button.dart';
import 'package:mist_app/common_widgets/images/default_background.dart';
import 'package:mist_app/common_widgets/sizedbox20.dart';
import 'package:mist_app/constants/fonts.dart';
import 'package:mist_app/view/admin_view/coordinator_uid_screen.dart';

class IdentifyCoordinator extends StatelessWidget {
  const IdentifyCoordinator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const DefaultBackground(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.arrow_back_ios_sharp,
                      size: 15,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox20(),
                  Text(
                    "Current Road",
                    style: TextStyle(fontSize: 36, fontFamily: fontFamily2),
                  ),
                  Text(
                    "Accident history",
                    style: TextStyle(fontSize: 26, fontFamily: fontFamily2),
                  ),
                  const SizedBox20(),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     CircleAvatar(
                  //       maxRadius: 35,
                  //       child: Image.asset("assets/images/road.jpg"),
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     // Container(
                  //     //
                  //     //   height: 285,
                  //     //   child:  Padding(
                  //     //     padding: const EdgeInsets.all(10.0),
                  //     //     child: Column(
                  //     //       crossAxisAlignment: CrossAxisAlignment.start,
                  //     //       children: [
                  //     //         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     //           children: [
                  //     //             Text(
                  //     //               "29/02/2024  12:34 PM",
                  //     //               style:  TextStyle(fontSize: 10,color: Colors.black.withOpacity(0.6)),
                  //     //             ),
                  //     //           ],
                  //     //         ),
                  //     //         const Text(
                  //     //           "Other User\naccident details will appear hear",
                  //     //           style: TextStyle(fontSize: 16),
                  //     //         ),
                  //     //         const SizedBox10(),
                  //     //         const Text(
                  //     //           "NID\n20102909201920912",
                  //     //           style: TextStyle(fontSize: 16),
                  //     //         ),
                  //     //         const SizedBox10(),
                  //     //         const Text(
                  //     //           "UID\n20102909201920912",
                  //     //           style: TextStyle(fontSize: 16),
                  //     //         ),
                  //     //         const SizedBox10(),
                  //     //         const Text(
                  //     //           "Location",
                  //     //           style: TextStyle(
                  //     //               fontSize: 16, fontWeight: FontWeight.bold),
                  //     //         ),
                  //     //         const Text(
                  //     //           "Latitude: 30.0626 ",
                  //     //           style: TextStyle(fontSize: 16),
                  //     //         ),
                  //     //         const Text(
                  //     //           "Longitude: 31.2497",
                  //     //           style: TextStyle(fontSize: 16),
                  //     //         ),
                  //     //       ],
                  //     //     ),
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  CustomButton(text: "Add coordinaror", onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const CoordinatorUID(),),);
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
