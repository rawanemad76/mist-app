import 'dart:convert';
import 'package:dio/dio.dart';

class ApiService {
  final String apiUrl = 'https://smart-mist.azurewebsites.net/roads/number-of-cam';
  final Dio _dio = Dio();

  Future<Map<String, int>> getCamerasPerRoad() async {
    try {
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        Map<String, int> camerasPerRoad = {};
        data.forEach((road) {
          String roadName = road['roadName'];
          int numberOfCameras = road['numberOfCameras'];
          camerasPerRoad[roadName] = numberOfCameras;
        });

        return camerasPerRoad;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}