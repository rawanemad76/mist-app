class NotificationDataModel {
  String title;
  String content;

  NotificationDataModel({
    required this.title,
    required this.content,
  });

  factory NotificationDataModel.fromJson(json) {
    return NotificationDataModel(
        title: json['title'], content: json['content']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "title": title,
      "content": content,
    };
  }

  @override
  String toString() {
    return 'notification: $title: $content';
  }
}
