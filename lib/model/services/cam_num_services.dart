
import 'dart:developer';

import 'package:dio/dio.dart';

class CamNumService {
  static Future<int> getNumberOfCameras(String roadName) async {
    final dio = Dio();
    final response = await dio.get(
        'https://mist-app.azurewebsites.net/roads/number-of-cam',
        queryParameters: {'road_name': roadName}
    );

    if (response.statusCode == 200 && response.data != null) {
      final data = response.data;
      if (data is Map<String, dynamic> && data.containsKey(roadName)) {
        return data[roadName];
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to load number of cameras');
    }
  }
}