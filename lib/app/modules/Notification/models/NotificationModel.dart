class NotificationModel {
  String? firstName;
  String? lastName;

  NotificationModel({
    this.firstName,
    this.lastName,
  });

  NotificationModel copyWith({
    String? firstName,
    String? lastName,
  }) =>
      NotificationModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
  };
}

