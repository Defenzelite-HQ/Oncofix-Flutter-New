// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
  ScheduleModel({
    this.id,
    this.userId,
    this.day,
    this.startTime,
    this.endTime,
    this.booked,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? userId;
  String? day;
  String? startTime;
  String? endTime;
  bool? booked;
  String? createdAt;
  String? updatedAt;

  ScheduleModel copyWith({
    int? id,
    String? userId,
    String? day,
    String? startTime,
    String? endTime,
    bool? booked,
    String? createdAt,
    String? updatedAt,
  }) =>
      ScheduleModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        day: day ?? this.day,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        booked: booked ?? this.booked,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        day: json["day"] == null ? null : json["day"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        booked: json["booked"] == null ? false : json["booked"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "day": day == null ? null : day,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "booked": booked == null ? false : booked,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
