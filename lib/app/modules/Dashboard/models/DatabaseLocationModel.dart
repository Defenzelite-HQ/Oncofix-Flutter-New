class DatabaseLocationModel {
  DatabaseLocationModel({
    this.currentLocation,
    this.destinationLocation,
  });

  Locations? currentLocation;
  Locations? destinationLocation;

  DatabaseLocationModel copyWith({
    Locations? currentLocation,
    Locations? destinationLocation,
  }) =>
      DatabaseLocationModel(
        currentLocation: currentLocation ?? this.currentLocation,
        destinationLocation: destinationLocation ?? this.destinationLocation,
      );

  factory DatabaseLocationModel.fromJson(Map<String, dynamic> json) => DatabaseLocationModel(
        currentLocation: json["currentLocation"] == null ? null : Locations.fromJson(json["currentLocation"]),
        destinationLocation: json["destinationLocation"] == null ? null : Locations.fromJson(json["destinationLocation"]),
      );

  Map<String, dynamic> toJson() => {
        "currentLocation": currentLocation?.toJson(),
        "destinationLocation": destinationLocation?.toJson(),
      };
}

class Locations {
  Locations({
    this.address,
    this.lat,
    this.lon,
  });

  String? address;
  String? lat;
  String? lon;

  Locations copyWith({
    String? address,
    String? lat,
    String? lon,
  }) =>
      Locations(
        address: address ?? this.address,
        lat: lat ?? this.lat,
        lon: lon ?? this.lon,
      );

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
        address: json["address"],
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "lat": lat,
        "lon": lon,
      };
}
