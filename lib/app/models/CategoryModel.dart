// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.level,
    this.categoryId,
    this.parentId,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.childrenCategories,
  });

  int? id;
  String? name;
  int? level;
  int? categoryId;
  dynamic parentId;
  String? icon;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<CategoryModel>? childrenCategories;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        level: json["level"] == null ? null : json["level"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        parentId: json["parent_id"],
        icon: json["icon"] == null ? null : json["icon"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        childrenCategories: json["children_categories"] == null ? null : List<CategoryModel>.from(json["children_categories"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "level": level == null ? null : level,
        "category_id": categoryId == null ? null : categoryId,
        "parent_id": parentId,
        "icon": icon == null ? null : icon,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "children_categories": childrenCategories == null ? null : List<dynamic>.from(childrenCategories!.map((x) => x.toJson())),
      };

  /// Checks if this model has id
  ///
  bool get isEmpty => this.id == null;

  /// Checks if this model has id
  ///
  bool get isNotEmpty => this.id != null;

  /// Returns the object as a string
  ///
  String encoded() => jsonEncode(this.toJson());
}
