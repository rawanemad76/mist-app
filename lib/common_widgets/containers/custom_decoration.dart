// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class CustomDecoration extends StatelessWidget {
   CustomDecoration({super.key,required this.height,required this.content, this.width =double.infinity});
  Widget content;
  double height;
  double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 1,

              //spreadRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(15),

        ),
        child:  Padding(
          padding: const EdgeInsets.all(6.5),
          child: content,
        ),
      ),
    );
  }
}
