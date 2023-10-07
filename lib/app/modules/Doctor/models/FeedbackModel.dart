// To parse this JSON data, do
//
//     final feedbackModel = feedbackModelFromJson(jsonString);

import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) =>
    FeedbackModel.fromJson(json.decode(str));

String feedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());

class FeedbackModel {
  FeedbackModel({
    this.id,
    this.userId,
    this.doctorId,
    this.appointmentId,
    this.rating,
    this.feedback,
    this.isPublished,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
  });

  int? id;
  String? userId;
  String? doctorId;
  String? appointmentId;
  dynamic rating;
  String? feedback;
  String? isPublished;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic user;

  FeedbackModel copyWith({
    int? id,
    String? userId,
    String? doctorId,
    String? appointmentId,
    dynamic rating,
    String? feedback,
    String? isPublished,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    dynamic user,
  }) =>
      FeedbackModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        doctorId: doctorId ?? this.doctorId,
        appointmentId: appointmentId ?? this.appointmentId,
        rating: rating ?? this.rating,
        feedback: feedback ?? this.feedback,
        isPublished: isPublished ?? this.isPublished,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        user: user ?? this.user,
      );

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        appointmentId:
            json["appointment_id"] == null ? null : json["appointment_id"],
        rating: json["rating"],
        feedback: json["feedback"] == null ? null : json["feedback"],
        isPublished: json["is_published"] == null ? null : json["is_published"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        deletedAt: json["deleted_at"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "doctor_id": doctorId == null ? null : doctorId,
        "appointment_id": appointmentId == null ? null : appointmentId,
        "rating": rating,
        "feedback": feedback == null ? null : feedback,
        "is_published": isPublished == null ? null : isPublished,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "deleted_at": deletedAt,
        "user": user,
      };
}
