const String stub = """
class {MODULE}Model {
  String? firstName;
  String? lastName;

  {MODULE}Model({
    this.firstName,
    this.lastName,
  });

  {MODULE}Model copyWith({
    String? firstName,
    String? lastName,
  }) =>
      {MODULE}Model(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

  factory {MODULE}Model.fromJson(Map<String, dynamic> json) => {MODULE}Model(
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
  };
}
""";
