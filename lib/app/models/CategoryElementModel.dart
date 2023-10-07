// To parse this JSON data, do
//
//     final categoryElementModel = categoryElementModelFromJson(jsonString);

import 'dart:convert';

CategoryElementModel categoryElementModelFromJson(String str) => CategoryElementModel.fromJson(json.decode(str));

String categoryElementModelToJson(CategoryElementModel data) => json.encode(data.toJson());

class CategoryElementModel {
  CategoryElementModel({
    this.id,
    this.name,
    this.level,
    this.categoryTypeId,
    this.parentId,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  dynamic name;
  dynamic level;
  dynamic categoryTypeId;
  dynamic parentId;
  dynamic icon;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  CategoryElementModel copyWith({
    int? id,
    dynamic name,
    dynamic level,
    dynamic categoryTypeId,
    dynamic parentId,
    dynamic icon,
    dynamic createdAt,
    dynamic updatedAt,
    dynamic deletedAt,
  }) =>
      CategoryElementModel(
        id: id ?? this.id,
        name: name ?? this.name,
        level: level ?? this.level,
        categoryTypeId: categoryTypeId ?? this.categoryTypeId,
        parentId: parentId ?? this.parentId,
        icon: icon ?? this.icon,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory CategoryElementModel.fromJson(Map<String, dynamic> json) => CategoryElementModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    level: json["level"] == null ? null : json["level"],
    categoryTypeId: json["category_type_id"] == null ? null : json["category_type_id"],
    parentId: json["parent_id"],
    icon: json["icon"] == null ? null : json["icon"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "level": level == null ? null : level,
    "category_type_id": categoryTypeId == null ? null : categoryTypeId,
    "parent_id": parentId,
    "icon": icon == null ? null : icon,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "deleted_at": deletedAt,
  };
}
