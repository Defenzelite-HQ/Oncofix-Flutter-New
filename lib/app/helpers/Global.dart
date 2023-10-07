import 'dart:io';
import 'dart:math';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:logger/logger.dart';
import 'package:timezone/timezone.dart';
import 'package:ui_x/helpers/Toastr.dart';
import 'package:vibration/vibration.dart';
import 'package:http/http.dart' as http;
import 'package:oncofix/app/shared/controllers/FCMController.dart';
import '../../config/Config.dart';
import '../shared/controllers/AppController.dart';
import '../shared/controllers/AuthState.dart';

///======================================
/// Get Instance of [AuthState]
///======================================
AuthState authState = AuthState.instance;
AuthState auth = AuthState.instance;
AppController appController = AppController.instance;

///======================================
/// Get storage Helper
///======================================
GetStorage storage = new GetStorage();

///======================================
/// Get screen size helper
///======================================
Size screen = Get.size;

///======================================
/// Image Helper
///======================================
String image(name) {
  return "assets/icons/$name";
}

///======================================
/// Icon Helper
///======================================
String assetIcon(name) {
  return "assets/icons/$name";
}

///======================================
/// Check current route
///======================================
bool routeIs(name) {
  return Get.routing.current == name;
}

///======================================
/// Console Logger
///======================================
var log = Logger(
  printer: PrettyPrinter(),
);

///======================================
/// Formatted DateTime
///======================================
extension DateExt on DateTime {
  String formattedDateTime(String format) {
    return Jiffy(this.toString()).format(format);
  }
}

///======================================
/// Formatted Date Extension
///======================================
extension Date on DateFormat {
  String formatDate(DateTime date, String format) {
    return DateFormat(format).format(date);
  }
}

///======================================
/// Formatted Time Extension
///======================================
extension TimeExt on TimeOfDay {
  String formattedTime(String format) {
    return Jiffy(this.toString()).format(format);
  }
}

///======================================
/// Formatted Date
///======================================
String formattedDate(String date) {
  Map dateFormat = {
    "MMMM do yyyy, h:mm:ss a": 1,
    "MMM do yy": 2,
    "dd, MMM yyyy": 3,
    "yyyy-MM-dd": 4,
  };
  var dateFormatted = dateFormat.keys.firstWhere(
      (k) => dateFormat[k] == Config.dateFormatted,
      orElse: () => "null");
  print(dateFormatted);
  return Jiffy(date).format(dateFormatted.toString());
}

///======================================
/// Formatted Date
///======================================
String formattedTime(String time) {
  Map timeFormat = {
    "h:mm:ss a": 1,
    "h:mm:ss": 2,
    "h:mm": 3,
  };
  var timeFormatted = timeFormat.keys.firstWhere(
      (k) => timeFormat[k] == Config.dateFormatted,
      orElse: () => "null");
  return Jiffy(time).format(timeFormatted.toString());
}

///======================================
/// Formatted Currency Symbol
///======================================
String formatCurrencySymbol(String countryName) {
  var format = NumberFormat.simpleCurrency(
      locale: Platform.localeName, name: countryName);
  return format.currencySymbol;
}

///======================================
/// Formatted Currency
///======================================
///Ex:
///  Text(
///       "${formattedCurrency(100.00,"CAD")}",
///     ),
String formattedCurrency(double amount, String countryName) {
  var format = NumberFormat.simpleCurrency(
      locale: Platform.localeName, name: countryName);
  var formatSymbol = format.currencySymbol;
  var number = NumberFormat.currency(name: formatSymbol)
      .format(double.parse(amount.toStringAsFixed(0)));
  return number;
}

///======================================
/// Formatted Amount
///======================================
///Ex:
///
/// Text(
///     "${formattedTotalAmount("10000000000")}"),
///
String formattedTotalAmount(dynamic amount) {
  if (amount.length < 4) {
    return amount;
  } else if (amount.length >= 4 && amount.length < 6) {
    return (double.parse(amount) / 1000).toStringAsFixed(2) + "K";
  } else if (amount.length >= 6 && amount.length < 8) {
    return (double.parse(amount) / 100000).toStringAsFixed(2) + "L";
  } else {
    return (double.parse(amount) / 10000000).toStringAsFixed(2) + "Cr";
  }
}

///======================================
/// Formatted Amount
///======================================
///Ex:
///
/// Text(
///     "${formattedAmount("10000000000")}"),
///
String formattedAmount(dynamic amount) {
  var formatter = NumberFormat('##,##,##0');
  return (formatter.format(double.parse(amount.toString())));
}

///======================================
/// Random Point Generate
///======================================
///Ex:
///
///  Button(
///       key: UniqueKey(),
///       label: "Random Number",
///       onTap: (set) {
///         var random = rand(20, 30);
///         log.w(random);
///       },
///     ),
num rand([int min = 0, int max = 10]) {
  return min + Random().nextInt((max + 1) - min);
}

///======================================
/// Vibration
///======================================
void playVibration({int? duration, int? amplitude}) {
  Vibration.vibrate(duration: duration ?? 500, amplitude: amplitude ?? -1);
}

///======================================
/// Int, Double, String Parse
///======================================
int parseInt(int number) {
  return int.parse(number.toString());
}

double parseDouble(double number) {
  return double.parse(number.toString());
}

String parseString(String number) {
  return number;
}

/// Format Duration Time
/// Ex:
/// Text("${formatDuration(2000)}"),
///
String formatDuration(int seconds) {
  int minutes = seconds ~/ 60;
  int remainingSeconds = seconds % 60;
  String minutesString = minutes.toString().padLeft(2, '0');
  String secondsString = remainingSeconds.toString().padLeft(2, '0');
  return '$minutesString:$secondsString';
}

/// format Amount to text
/// Ex:
/// Text("${amountToText(1425)}"),
///
String amountToText(int amount) {
  final formattedAmount = amount;
  final dollarsInWords = _numberToWords(formattedAmount);
  String textFormat = '$dollarsInWords';
  return textFormat;
}

/// Helper to convert amount to text
String _numberToWords(int number) {
  if (number == 0) {
    return 'zero';
  }

  final List<String> units = [
    '',
    'thousand',
    'million',
    'billion',
    'trillion',
    'quadrillion'
  ];

  String words = '';

  for (int i = 0; number > 0; i++) {
    int threeDigits = number % 1000;
    if (threeDigits != 0) {
      String threeDigitsWords = _convertThreeDigitsToWords(threeDigits);
      words = '$threeDigitsWords ${units[i]} $words';
    }
    number ~/= 1000;
  }

  return words.trim();
}

String _convertThreeDigitsToWords(int number) {
  final List<String> onesPlace = [
    '',
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine'
  ];

  final List<String> teens = [
    'ten',
    'eleven',
    'twelve',
    'thirteen',
    'fourteen',
    'fifteen',
    'sixteen',
    'seventeen',
    'eighteen',
    'nineteen'
  ];

  final List<String> tensPlace = [
    '',
    '',
    'twenty',
    'thirty',
    'forty',
    'fifty',
    'sixty',
    'seventy',
    'eighty',
    'ninety'
  ];

  String words = '';

  int hundredsPlace = number ~/ 100;
  if (hundredsPlace > 0) {
    words = '${onesPlace[hundredsPlace]} hundred';
    number %= 100;
  }

  if (number >= 10 && number <= 19) {
    words = '$words ${teens[number - 10]}';
  } else {
    int tens = number ~/ 10;
    if (tens > 0) {
      words = '$words ${tensPlace[tens]}';
    }
    int ones = number % 10;
    if (ones > 0) {
      words = '$words ${onesPlace[ones]}';
    }
  }

  return words.trim();
}

/// Format Currency
/// Ex:
/// Text("${formatCurrency(1425)}"),
///
String formatCurrency(dynamic amount) {
  if (amount is double || amount is int) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(amount);
  } else {
    throw ArgumentError('Amount must be a double or int.');
  }
}

/// Local Time Zone Default Time show
/// Ex:
/// Text("${getLocalTime()}"),
///
DateTime getLocalTime() {
  DateTime currentTime = DateTime.now();
  return currentTime.toLocal();
}

/// format Date To String With TimeZone
String formatDateToStringWithTimeZone(DateTime date) {
  var dur = date.timeZoneOffset;
  if (dur.isNegative)
    return "${DateFormat("y-MM-ddTHH:mm:ss").format(date)}-${dur.inHours.toString().padLeft(2, '0')}:${(dur.inMinutes - (dur.inHours * 60)).toString().padLeft(2, '0')}";
  else
    return "${DateFormat("y-MM-ddTHH:mm:ss").format(date)}+${dur.inHours.toString().padLeft(2, '0')}:${(dur.inMinutes - (dur.inHours * 60)).toString().padLeft(2, '0')}";
}

/// Function to get the time zone for a country
///
/// Example
///   Text(
///      "${Jiffy(getUTC(DateTime.now().toUtc(), "India")).format("MM dd yyyy hh:mm:ss a")}",
///    ),
///
DateTime getUTC(DateTime utcDateTime, String countryName) {
  // Create a mapping of country names to time zone identifiers
  Map<String, String> countryTimezones = {
    'United States': 'America/New_York',
    'Canada': 'America/Toronto',
    'Mexico': 'America/Mexico_City',
    'Brazil': 'America/Sao_Paulo',
    'United Kingdom': 'Europe/London',
    'Germany': 'Europe/Berlin',
    'India': 'Asia/Kolkata',
    'China': 'Asia/Shanghai',
    'Japan': 'Asia/Tokyo',
    'Australia': 'Australia/Sydney',
    'New Zealand': 'Pacific/Auckland',
    'South Africa': 'Africa/Johannesburg',
    'Egypt': 'Africa/Cairo',
    'Russia': 'Europe/Moscow',
    'Argentina': 'America/Argentina/Buenos_Aires',
  };

  // Initialize the timezone database
  tzdata.initializeTimeZones();

  // Look up the time zone for the provided country name
  String? timezoneId = countryTimezones[countryName];

  if (timezoneId != null) {
    var detroit = tz.getLocation(timezoneId);

    // Calculate the UTC time in the specified timezone
    var now = tz.TZDateTime.from(utcDateTime, detroit);
    // Return the UTC time as a DateTime
    return now;
  } else {
    // Return the input UTC time if the country name is not found
    return utcDateTime;
  }
}

/// Download
/// Ex:
///
///  Button(
///        key: UniqueKey(),
///        label: "Download",
///        onTap: (set) {
///          downloadFile(
///              url:
///                  "https://cdn.pixabay.com/photo/2015/03/10/17/23/youtube-667451_1280.png",
///              filename: "Image",
///              title: "Youtube",
///              subtitle: "Video");
///        },
///      ),
///
Future<void> downloadFile({
  required String url,
  required String filename,
  required String title,
  required String subtitle,
}) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final bytes = response.bodyBytes;
    final FCMController fcmController = Get.put(FCMController());
    await fcmController.showProgressNotification(
      "$title",
      "$subtitle",
      "$url",
      (progress) {
        print('Progress: $progress%');
      },
    );
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$filename';

    File(filePath).writeAsBytes(bytes);
    // await GallerySaver.saveImage(filePath);
    Toastr.show(message: "'File downloaded to: $filePath'");
  } else {
    throw Exception('Failed to download file');
  }
}

/// Compress image
String imageQuality(String number) {
  return number;
}

Future<File?> croppedImage(imageFile) async {
  if (imageFile.path != "") {
    CroppedFile? cropped = await ImageCropper()
        .cropImage(sourcePath: imageFile.path, aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ], uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Crop',
          cropGridColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(title: 'Crop')
    ]);

    if (cropped != null) {
      File imageCrop = File(cropped.path);
      return imageCrop;
      // log.w(imageCrop.path);
    }
  }
}

///======================================
/// Theme Light & Dark Generate and get MaterialColor From a Color
///======================================
MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: _tintColor(color, 0.9),
    100: _tintColor(color, 0.8),
    200: _tintColor(color, 0.6),
    300: _tintColor(color, 0.4),
    400: _tintColor(color, 0.2),
    500: color,
    600: _shadeColor(color, 0.1),
    700: _shadeColor(color, 0.2),
    800: _shadeColor(color, 0.3),
    900: _shadeColor(color, 0.4),
  });
}

int _tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color _tintColor(Color color, double factor) => Color.fromRGBO(
    _tintValue(color.red, factor),
    _tintValue(color.green, factor),
    _tintValue(color.blue, factor),
    1);

int _shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color _shadeColor(Color color, double factor) => Color.fromRGBO(
      _shadeValue(color.red, factor),
      _shadeValue(color.green, factor),
      _shadeValue(color.blue, factor),
      1,
    );
