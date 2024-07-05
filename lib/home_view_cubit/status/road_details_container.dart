import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mist_app/constants/sizes.dart';
import 'package:mist_app/home_view_cubit/get_road_cubit/get_road_cubit.dart';

class RoadDetailsContainer extends StatelessWidget {
  const RoadDetailsContainer({super.key,});

  @override
  Widget build(BuildContext context) {
    var statusRoadInfoModel =
        BlocProvider.of<GetRoadCubit>(context).statusRoadInfoModel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        width: double.infinity,
        height: 290,
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
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: NetworkImage(
                        statusRoadInfoModel!.imagePath,
                        //image,
                      ),
                      fit: BoxFit.fill),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Condition : ${statusRoadInfoModel.className}",
                style: TextStyle(fontSize: containerTextFont),
              ),
              Text(
                "Confidence Score : ${statusRoadInfoModel.averageConfidenceScore.toStringAsFixed(4)}",
                style: TextStyle(fontSize: containerTextFont),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
