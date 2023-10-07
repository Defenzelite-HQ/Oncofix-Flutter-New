class OnBoardingModel {
  String? firstName;
  String? lastName;

  OnBoardingModel({
    this.firstName,
    this.lastName,
  });

  OnBoardingModel copyWith({
    String? firstName,
    String? lastName,
  }) =>
      OnBoardingModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) => OnBoardingModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
  };
}

