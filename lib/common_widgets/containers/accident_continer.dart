// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mist_app/constants/sizes.dart';

class AccidentDetailsContainer extends StatelessWidget {
  final String imagePlaceholder = 'assets/images/accident.png';
  final String? image;
  final String accidentDetails;
  final String date;
  VoidCallback? onTap;

  AccidentDetailsContainer({
    super.key,
    this.image,
    required this.accidentDetails,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 330,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 1),
                blurRadius: 3,
                spreadRadius: 1,

                //spreadRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  $date",
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: _imageWidget(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Details : $accidentDetails",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: containerTextFont),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    "Tap to show location",
                    style: TextStyle(fontSize: containerTextFont),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _imageWidget() {
    return image != null ? NetworkImage(image!) : AssetImage(imagePlaceholder);
    // return  NetworkImage(image!);
  }
}
