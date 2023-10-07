// To parse this JSON data, do
//
//     final doctorModel = doctorModelFromJson(jsonString);

import 'dart:convert';

import '../../../models/CategoryElementModel.dart';

DoctorModel doctorModelFromJson(String str) =>
    DoctorModel.fromJson(json.decode(str));

String doctorModelToJson(DoctorModel data) => json.encode(data.toJson());

class DoctorModel {
  DoctorModel({
    this.id,
    this.name,
    this.avatar,
    this.profileType,
    this.rating,
    this.bio,
    this.specializations,
    this.isVerified,
    this.category,
  });

  int? id;
  String? name;
  String? avatar;
  dynamic profileType;
  dynamic rating;
  dynamic bio;
  dynamic specializations;
  dynamic isVerified;
  CategoryElementModel? category;

  DoctorModel copyWith({
    int? id,
    String? name,
    String? avatar,
    dynamic profileType,
    dynamic rating,
    dynamic bio,
    dynamic specializations,
    dynamic isVerified,
    CategoryElementModel? category,
  }) =>
      DoctorModel(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        profileType: profileType ?? this.profileType,
        rating: rating ?? this.rating,
        bio: bio ?? this.bio,
        specializations: specializations ?? this.specializations,
        isVerified: isVerified ?? this.isVerified,
        category: category ?? this.category,
      );

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    profileType: json["profile_type"] == null ? null : json["profile_type"],
    bio: json["bio"] == null ? null : json["bio"],
    specializations:
    json["specializations"] == null ? null : json["specializations"],
    rating: json["rating"] == null ? null : json["rating"],
    isVerified: json["is_verified"] == null ? null : json["is_verified"],
    category: json["category"] == null
        ? null
        : CategoryElementModel.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "avatar": avatar == null ? null : avatar,
    "profile_type": profileType == null ? null : profileType,
    "rating": rating == null ? null : rating,
    "bio": bio == null ? null : bio,
    "specializations": specializations == null ? null : specializations,
    "is_verified": isVerified == null ? null : isVerified,
    "category": category == null ? null : category!.toJson(),
  };
}
