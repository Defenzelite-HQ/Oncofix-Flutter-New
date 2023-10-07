
import 'dart:convert';

MeetingModel meetingModelFromJson(String str) => MeetingModel.fromJson(json.decode(str));

String meetingModelToJson(MeetingModel data) => json.encode(data.toJson());

class MeetingModel {
  MeetingModel({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.categoryId,
    this.link,
    this.dateTime,
    this.banner,
    this.isApproved,
    this.public,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? userId;
  String? name;
  String? description;
  String? categoryId;
  String? link;
  String? dateTime;
  dynamic banner;
  String? isApproved;
  String? public;
  String? createdAt;
  String? updatedAt;

  MeetingModel copyWith({
    int? id,
    String? userId,
    String? name,
    String? description,
    String? categoryId,
    String? link,
    String? dateTime,
    dynamic banner,
    String? isApproved,
    String? public,
    String? createdAt,
    String? updatedAt,
  }) =>
      MeetingModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        description: description ?? this.description,
        categoryId: categoryId ?? this.categoryId,
        link: link ?? this.link,
        dateTime: dateTime ?? this.dateTime,
        banner: banner ?? this.banner,
        isApproved: isApproved ?? this.isApproved,
        public: public ?? this.public,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    link: json["link"] == null ? null : json["link"],
    dateTime: json["date_time"] == null ? null : json["date_time"],
    banner: json["banner"],
    isApproved: json["is_approved"] == null ? null : json["is_approved"],
    public: json["public"] == null ? null : json["public"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "category_id": categoryId == null ? null : categoryId,
    "link": link == null ? null : link,
    "date_time": dateTime == null ? null : dateTime,
    "banner": banner,
    "is_approved": isApproved == null ? null : isApproved,
    "public": public == null ? null : public,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
