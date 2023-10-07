import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'Global.dart';



/// Current Position Location Address Find.
/// Create Address Model
///
/// {
///   "name": "Lugharwara",
///   "street": "Near Bharat Petroleum",
///   "isoCountryCode": "IN",
///   "country": "India",
///   "postalCode": "480661",
///   "administrativeArea": "Madhya Pradesh",
///   "subAdministrativeArea": "Jabalpur Division",
///   "locality": "Lugharwara",
///   "subLocality": "",
///   "thoroughfare": "",
///   "subThoroughfare": ""
/// }
///
void currentAddress(Position position) async {
  await placemarkFromCoordinates(position.latitude, position.longitude)
      .then((List<Placemark> placemarks) async {
    Placemark place = placemarks[0];
    log.e(place.toJson());
    return place.toJson();
  });
}

/// Current Location LatLong
///
/// Create Model for this json file
///
/// {
///   "longitude": 79.5443914,
///   "latitude": 22.1109557,
///   "timestamp": 1694851317546,
///   "accuracy": 20.100000381469727,
///   "altitude": 0.0,
///   "floor": null,
///   "heading": 0.0,
///   "speed": 0.0,
///   "speed_accuracy": 0.0,
///   "is_mocked": false
/// }
///
Future<void> getCurrentPosition() async {
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
      .then((Position position) async {
    log.e(position.toJson());
    currentAddress(position);
    return position;
  });
}

/// Google Map custom marker to convert to image
///
/// Example:
///
/// final Uint8List markerIcon = await getBytesFromAsset('assets/icons/marker_logo.png', 50);
///
Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

/// Google Map Marker Add
///
/// Example:
///  googleMapMarker(
///     lat: 22.3991381,
///     long: 22.3991381,
///     image: "assets/icons/marker_logo.png",
///     title: "Current Location",
///     snippet: "Current Address"),
///
Future<Marker> googleMapMarker({
  required double lat,
  required double long,
  required String image,
  required String? title,
  required String? snippet,
}) async {
  final Uint8List markerIcon = await getBytesFromAsset(image, 50);
  Marker newMarker = Marker(
    markerId: MarkerId("MarkerId$lat$long"),
    position: LatLng(lat, long),
    infoWindow: InfoWindow(
        title: title ?? 'Current Location', snippet: snippet ?? 'Chhapara'),
    icon: BitmapDescriptor.fromBytes(markerIcon),
  );
  return newMarker;
}
