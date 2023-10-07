class CasesModel {
  String? firstName;
  String? lastName;

  CasesModel({
    this.firstName,
    this.lastName,
  });

  CasesModel copyWith({
    String? firstName,
    String? lastName,
  }) =>
      CasesModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory CasesModel.fromJson(Map<String, dynamic> json) => CasesModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
  };
}

