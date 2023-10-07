class LanguageModel {
  LanguageModel({
    this.code,
    this.name,
    this.nativeName,
  });

  String? code;
  String? name;
  String? nativeName;

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        code: json["code"] == null ? 'en' : json["code"],
        name: json["name"] == null ? 'English' : json["name"],
        nativeName: json["nativeName"] == null ? 'English' : json["nativeName"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? 'en' : code,
        "name": name == null ? 'English' : name,
        "nativeName": nativeName == null ? 'English' : nativeName,
      };
}
