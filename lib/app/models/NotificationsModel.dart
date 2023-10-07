// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'UserModel.dart';

class NotificationsModel {
  NotificationsModel({
    this.id,
    this.userId,
    this.title,
    this.notification,
    this.isRead,
    this.link,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int? id;
  int? userId;
  String? title;
  String? notification;
  String? isRead;
  String? link;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;
  UserModel? user;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        title: json["title"] == null ? null : json["title"],
        notification: json["notification"] == null ? null : json["notification"],
        isRead: json["is_read"] == null ? null : json["is_read"],
        link: json["link"] == null ? null : json["link"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: json["user"] == UserModel ? null : UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "title": title == null ? null : title,
        "notification": notification == null ? null : notification,
        "is_read": isRead == null ? null : isRead,
        "link": link == null ? null : link,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user == null ? null : user?.toJson(),
      };
}
