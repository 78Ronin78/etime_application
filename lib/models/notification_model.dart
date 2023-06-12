import 'dart:convert';

class NotificationModel {
  String? title;
  String imagePath;
  String? description;
  DateTime dateTime;
  bool isRead;
  String buttonTitle;
  String buttonUrl;

  NotificationModel(
      {required this.description,
      required this.imagePath,
      required this.dateTime,
      required this.title,
      required this.isRead,
      required this.buttonTitle,
      required this.buttonUrl});
  factory NotificationModel.fromJson(Map parsedJson) => NotificationModel(
      dateTime: parsedJson['date_time'],
      description: parsedJson['description'],
      imagePath: parsedJson['image_path'],
      title: parsedJson['title'],
      isRead: parsedJson['isRead'],
      buttonTitle: parsedJson['button_title'],
      buttonUrl: parsedJson['button_url']);

  static Map<String, dynamic> toMap(NotificationModel notificationList) => {
        'date_time': notificationList.dateTime,
        'description': notificationList.description,
        'image_path': notificationList.imagePath,
        'title': notificationList.title,
        'isRead': notificationList.isRead,
        'button_title': notificationList.buttonTitle,
        'button_url': notificationList.buttonUrl
      };

  static String encode(List<NotificationModel> notifications) => json.encode(
        notifications
            .map<Map<String, dynamic>>(
                (notification) => NotificationModel.toMap(notification))
            .toList(),
      );

  static List<NotificationModel> decode(String notifications) =>
      (json.decode(notifications) as List<dynamic>)
          .map<NotificationModel>((item) => NotificationModel.fromJson(item))
          .toList();
}
