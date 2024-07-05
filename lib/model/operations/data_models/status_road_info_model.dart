class StatusRoadInfoModel {
  final double averageConfidenceScore;
  final String className;
  final String imagePath;
 
  StatusRoadInfoModel({
    required this.averageConfidenceScore,
    required this.className,
    required this.imagePath,
  });

  factory StatusRoadInfoModel.fromJson(Map<String, dynamic> json) {
    return StatusRoadInfoModel(
      averageConfidenceScore: json['average_confidence_score'],
      className: json['class_name'],
      imagePath: json['image_path'],
    );
  }
}
