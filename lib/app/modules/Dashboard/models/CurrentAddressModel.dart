class CurrentAddressModel {
  CurrentAddressModel({
    this.name,
    this.street,
    this.isoCountryCode,
    this.country,
    this.postalCode,
    this.administrativeArea,
    this.subAdministrativeArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  });

  String? name;
  String? street;
  String? isoCountryCode;
  String? country;
  String? postalCode;
  String? administrativeArea;
  String? subAdministrativeArea;
  String? locality;
  String? subLocality;
  String? thoroughfare;
  String? subThoroughfare;

  CurrentAddressModel copyWith({
    String? name,
    String? street,
    String? isoCountryCode,
    String? country,
    String? postalCode,
    String? administrativeArea,
    String? subAdministrativeArea,
    String? locality,
    String? subLocality,
    String? thoroughfare,
    String? subThoroughfare,
  }) =>
      CurrentAddressModel(
        name: name ?? this.name,
        street: street ?? this.street,
        isoCountryCode: isoCountryCode ?? this.isoCountryCode,
        country: country ?? this.country,
        postalCode: postalCode ?? this.postalCode,
        administrativeArea: administrativeArea ?? this.administrativeArea,
        subAdministrativeArea: subAdministrativeArea ?? this.subAdministrativeArea,
        locality: locality ?? this.locality,
        subLocality: subLocality ?? this.subLocality,
        thoroughfare: thoroughfare ?? this.thoroughfare,
        subThoroughfare: subThoroughfare ?? this.subThoroughfare,
      );

  factory CurrentAddressModel.fromJson(Map<String, dynamic> json) => CurrentAddressModel(
    name: json["name"],
    street: json["street"],
    isoCountryCode: json["isoCountryCode"],
    country: json["country"],
    postalCode: json["postalCode"],
    administrativeArea: json["administrativeArea"],
    subAdministrativeArea: json["subAdministrativeArea"],
    locality: json["locality"],
    subLocality: json["subLocality"],
    thoroughfare: json["thoroughfare"],
    subThoroughfare: json["subThoroughfare"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "street": street,
    "isoCountryCode": isoCountryCode,
    "country": country,
    "postalCode": postalCode,
    "administrativeArea": administrativeArea,
    "subAdministrativeArea": subAdministrativeArea,
    "locality": locality,
    "subLocality": subLocality,
    "thoroughfare": thoroughfare,
    "subThoroughfare": subThoroughfare,
  };
}
