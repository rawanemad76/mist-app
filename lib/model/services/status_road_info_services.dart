import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:mist_app/model/operations/data_models/status_road_info_model.dart';

class StatusRoadInfoServices {
  final Dio dio;
  StatusRoadInfoServices(this.dio);

  Future<StatusRoadInfoModel> getStatusRoadInfo(
      {required String roadName}) async {
    try {
      final encodedRoadName = Uri.encodeComponent(roadName);
      final url = 'https://mist-app.azurewebsites.net/?label=$encodedRoadName';
      log('Request URL: $url');

      Response response = await dio.get(url);
      log('===================Response status code: ${response.statusCode}');
      log('Response data: ${response.data}');

      try {
        const String baseUrl = 'https://mist-app.azurewebsites.net/';
        final String imagePath = response.data['image_path'];
        final String imageUrl = '$baseUrl$imagePath';
        response.data['image_path'] = imageUrl;
        log("========================================$imageUrl");

        StatusRoadInfoModel statusRoadInfoModel =
        StatusRoadInfoModel.fromJson(response.data);
        log('Parsed data: $statusRoadInfoModel');
        return statusRoadInfoModel;
      } catch (e) {
        log('Error parsing response data: $e');
        throw Exception('Failed to parse response data');
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['error']['message'] ?? "Oops there was an error";
      throw (errorMessage);
    } catch (e) {
      throw ("Oops there was an error , try later");
    }
  }
}
