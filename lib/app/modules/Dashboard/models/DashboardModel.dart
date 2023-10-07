class DashboardModel {
  String? firstName;
  String? lastName;

  DashboardModel({
    this.firstName,
    this.lastName,
  });

  DashboardModel copyWith({
    String? firstName,
    String? lastName,
  }) =>
      DashboardModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
  };
}

