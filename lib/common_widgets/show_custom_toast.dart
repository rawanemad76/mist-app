import 'package:flutter/material.dart';
import 'package:mist_app/constants/colors.dart';
import '../constants/fonts.dart';

void showCustomToast(BuildContext context) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 30.0,
      left: 110.0,
      right: 110.0,
      child: Material(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width:200,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
           color: ColorManager.toast,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check, color: Colors.black,),
              const SizedBox(width: 5.0),
              Text(
                "Done",
                style: TextStyle(color: Colors.black,fontSize: 18, fontFamily: fontFamily1),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}












// void showAlertDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//         height: 46,
//         width: 200,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8)
//         ),
//         child:  AlertDialog(
//           buttonPadding: EdgeInsets.symmetric(horizontal: 300),
//
//           alignment: Alignment.bottomCenter,
//           shape: BeveledRectangleBorder(
//             borderRadius: BorderRadius.circular(0.8),
//           ),
//
//           backgroundColor: ColorManager.toast,
//           content: Row(
//             children: [
//               Icon(Icons.check, color: Colors.green),
//               SizedBox(width: 10),
//               Text("Done"),
//             ],
//           ),
//           // actions: [
//           //   TextButton(
//           //     child: Text('OK'),
//           //     onPressed: () {
//           //       Navigator.of(context).pop();
//           //     },
//           //   ),
//           // ],
//         ),
//       );
//     },
//   );
// }





// void showSnackBar(BuildContext context) {
//   final snackBar = SnackBar(
//     content: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(Icons.check, color: Colors.white),
//         SizedBox(width: 10.0),
//         Text("Done"),
//       ],
//     ),
//     backgroundColor: Colors.black,
//     duration: Duration(seconds: 2),
//   );
//
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }