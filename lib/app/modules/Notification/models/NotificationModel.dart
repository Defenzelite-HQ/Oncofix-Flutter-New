// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  int? id;
  int? userId;
  String? title;
  String? notification;
  String? isReaded;
  String? link;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationModel({
    this.id,
    this.userId,
    this.title,
    this.notification,
    this.isReaded,
    this.link,
    this.createdAt,
    this.updatedAt,
  });

  NotificationModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? notification,
    String? isReaded,
    String? link,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        notification: notification ?? this.notification,
        isReaded: isReaded ?? this.isReaded,
        link: link ?? this.link,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    notification: json["notification"],
    isReaded: json["is_readed"],
    link: json["link"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "notification": notification,
    "is_readed": isReaded,
    "link": link,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
