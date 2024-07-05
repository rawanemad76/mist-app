import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mist_app/home_view_cubit/get_road_cubit/get_road_status.dart';
import 'package:mist_app/model/services/status_road_info_services.dart';

import '../../model/operations/data_models/status_road_info_model.dart';

class GetRoadCubit extends Cubit<RoadStates>{


  GetRoadCubit():super(RoadInitialState());

  StatusRoadInfoModel? statusRoadInfoModel;

  getRoad({required String roadName})async{
    try {
      log('===========================Cubit: Starting getRoad with roadName: $roadName');
      statusRoadInfoModel =
      await StatusRoadInfoServices(Dio()).getStatusRoadInfo(roadName: roadName);
      log('=========================Cubit: Road information loaded successfully');
      emit(RoadLoadedState());
    } catch(e){
      log('======================Cubit: Failed to load road information: $e');
      emit(RoadFailureState(errorMessage: e.toString()));
    }
  }

}