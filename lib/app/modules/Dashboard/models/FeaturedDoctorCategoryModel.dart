// ignore_for_file: unnecessary_null_comparison

class FeaturedDoctorCategoryModel {
  FeaturedDoctorCategoryModel({
    this.name,
  });

  String? name;

  FeaturedDoctorCategoryModel copyWith({
    String? name,
  }) =>
      FeaturedDoctorCategoryModel(
        name: name ?? this.name,
      );

  factory FeaturedDoctorCategoryModel.fromJson(Map<String, dynamic> json) =>
      FeaturedDoctorCategoryModel(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };
}
