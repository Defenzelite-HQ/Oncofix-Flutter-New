// To parse this JSON data, do
//
//     final myAppointmentModel = myAppointmentModelFromJson(jsonString);

import 'dart:convert';
import '../../Doctor/models/DoctorModel.dart';

MyAppointmentModel myAppointmentModelFromJson(String str) =>
    MyAppointmentModel.fromJson(json.decode(str));

String myAppointmentModelToJson(MyAppointmentModel data) =>
    json.encode(data.toJson());

class MyAppointmentModel {
  MyAppointmentModel({
    this.id,
    this.userId,
    this.consultantId,
    this.dateTime,
    this.price,
    this.paymentStatus,
    this.status,
    this.paidPrice,
    this.platformFee,
    this.dateEndTime,
    this.type,
    this.appointmentType,
    this.doctor,
    this.workstreamId,
  });

  int? id;
  String? userId;
  String? consultantId;
  String? dateTime;
  String? price;
  String? paymentStatus;
  String? status;
  String? paidPrice;
  String? platformFee;
  String? dateEndTime;
  String? type;
  String? appointmentType;
  String? workstreamId;
  DoctorModel? doctor;

  MyAppointmentModel copyWith({
    int? id,
    String? userId,
    String? consultantId,
    String? dateTime,
    String? price,
    String? paymentStatus,
    String? status,
    String? paidPrice,
    String? platformFee,
    String? dateEndTime,
    String? type,
    String? appointmentType,
    String? workstreamId,
    DoctorModel? doctor,
  }) =>
      MyAppointmentModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        consultantId: consultantId ?? this.consultantId,
        dateTime: dateTime ?? this.dateTime,
        price: price ?? this.price,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        status: status ?? this.status,
        paidPrice: paidPrice ?? this.paidPrice,
        platformFee: platformFee ?? this.platformFee,
        dateEndTime: dateEndTime ?? this.dateEndTime,
        type: type ?? this.type,
        appointmentType: appointmentType ?? this.appointmentType,
        workstreamId: workstreamId ?? this.workstreamId,
        doctor: doctor ?? this.doctor,
      );

  factory MyAppointmentModel.fromJson(Map<String, dynamic> json) =>
      MyAppointmentModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"].toString(),
        consultantId:
        json["consultant_id"] == null ? null : json["consultant_id"].toString(),
        dateTime: json["date_time"] == null ? null : json["date_time"],
        price: json["price"] == null ? null : json["price"],
        paymentStatus:
        json["payment_status"] == null ? null : json["payment_status"].toString(),
        status: json["status"] == null ? null : json["status"].toString(),
        paidPrice: json["paid_price"] == null ? null : json["paid_price"].toString(),
        platformFee: json["platform_fee"] == null ? null : json["platform_fee"].toString(),
        dateEndTime:
        json["date_end_time"] == null ? null : json["date_end_time"],
        type: json["type"] == null ? null : json["type"],
        appointmentType: json["appointment_type"] == null ? null : json["appointment_type"],
        workstreamId: json["workstream_id"] == null ? null : json["workstream_id"].toString(),
        doctor: json["doctor"] == null
            ? null
            : DoctorModel.fromJson(json["doctor"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "consultant_id": consultantId == null ? null : consultantId,
    "date_time": dateTime == null ? null : dateTime,
    "price": price == null ? null : price,
    "payment_status": paymentStatus == null ? null : paymentStatus,
    "status": status == null ? null : status,
    "paid_price": paidPrice == null ? null : paidPrice,
    "platform_fee": platformFee == null ? null : platformFee,
    "date_end_time": dateEndTime == null ? null : dateEndTime,
    "type": type == null ? null : type,
    "appointment_type": appointmentType == null ? null : appointmentType,
    "workstream_id": workstreamId == null ? null : workstreamId,
    "doctor": doctor == null ? null : doctor?.toJson(),
  };
}
