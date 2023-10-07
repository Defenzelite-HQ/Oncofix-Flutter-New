class AboutModel {
  String? firstName;
  String? lastName;

  AboutModel({
    this.firstName,
    this.lastName,
  });

  AboutModel copyWith({
    String? firstName,
    String? lastName,
  }) =>
      AboutModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
  };
}

