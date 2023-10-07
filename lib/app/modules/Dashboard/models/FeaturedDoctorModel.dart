import 'FeaturedDoctorCategoryModel.dart';

class FeaturedDoctorModel {
  FeaturedDoctorModel({
    this.id,
    this.name,
    this.avatar,
    this.specializations,
    this.profileType,
    this.rating,
    this.patientCount,
    this.category,
  });

  int? id;
  String? name;
  String? avatar;
  String? specializations;
  String? profileType;
  dynamic rating;
  int? patientCount;
  FeaturedDoctorCategoryModel? category;

  FeaturedDoctorModel copyWith({
    int? id,
    String? name,
    String? avatar,
    String? specializations,
    String? profileType,
    dynamic rating,
    int? patientCount,
    FeaturedDoctorCategoryModel? category,
  }) =>
      FeaturedDoctorModel(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        specializations: specializations ?? this.specializations,
        profileType: profileType ?? this.profileType,
        rating: rating ?? this.rating,
        patientCount: patientCount ?? this.patientCount,
        category: category ?? this.category,
      );

  factory FeaturedDoctorModel.fromJson(Map<String, dynamic> json) =>
      FeaturedDoctorModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        specializations:
            json["specializations"] == null ? null : json["specializations"],
        profileType: json["profile_type"] == null ? null : json["profile_type"],
        rating: json["rating"],
        patientCount:
            json["patient_count"] == null ? null : json["patient_count"],
        category: json["category"] == null
            ? null
            : FeaturedDoctorCategoryModel.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "avatar": avatar == null ? null : avatar,
        "specializations": specializations == null ? null : specializations,
        "profile_type": profileType == null ? null : profileType,
        "rating": rating,
        "patient_count": patientCount == null ? null : patientCount,
        "category": category == null ? null : category?.toJson(),
      };
}
