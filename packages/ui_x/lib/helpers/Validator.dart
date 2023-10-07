import 'package:get/get.dart';

import 'Str.dart';

class Validator {
  Map<String, String> errors = {};
  final String field;
  final String value;

  Validator(this.field, this.value);

  /// Required rule
  Validator required() {
    if (GetUtils.isLengthLessOrEqual(value, 0)) {
      errors.assign("$field", "${Str.ucFirst(field)} is required");
    }
    return this;
  }

  /// Email rule
  Validator email() {
    if (!GetUtils.isEmail(value)) {
      errors.assign("$field", "${Str.ucFirst(field)} needs to be an email!");
    }
    return this;
  }

  /// Equal rule
  Validator isEqual(dynamic val, String fieldMatchWith) {
    if (value != val) {
      errors.assign("$field",
          "${Str.ucFirst(fieldMatchWith)} and ${Str.ucFirst(field)} doesn't match!");
    }
    return this;
  }

  /// Number rule
  Validator number() {
    if (!GetUtils.isNull(value)) {
      errors.assign("$field", "${Str.ucFirst(field)} needs to be a number!");
    }
    return this;
  }

  /// Min character rule
  Validator min(int minLength) {
    if (value.length < minLength) {
      errors.assign(
          "$field", "${Str.ucFirst(field)} must be $minLength character!");
    }
    return this;
  }

  /// Max character rule
  Validator max(int maxLength) {
    if (GetUtils.isLengthGreaterThan(value, maxLength)) {
      errors.assign("$field",
          "${Str.ucFirst(field)} must be less than or equal to $maxLength character!");
    }
    return this;
  }

  /// Characters length is between given rule
  Validator between(int minLength, int maxLength) {
    if (!GetUtils.isLengthBetween(value, minLength, maxLength)) {
      errors.assign("$field",
          "${Str.ucFirst(field)} must be between $minLength and $maxLength character!");
    }
    return this;
  }

  /// Value does not contain any special character
  Validator specialCharacter({String? allowed}) {
    if (value.contains(RegExp(r'[\s\-$&+,:;=?@#|<>\.^*()%!\\]'))) {
      errors.assign("$field",
          "${Str.ucFirst(field)} not allow any special character except underscores (_)");
    }
    return this;
  }

  /// Validate the string
  String? validate() {
    return errors["$field"];
  }

  /// Checks if string is phone number.
  static bool isPanNumber(String s) {
    if (s.length > 9 || s.length < 11) return false;
    return hasMatch(s, r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
  }

  String validatePancard(String value) {
    String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please Enter Pancard Number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please Enter Valid Pancard Number';
    }
    return "";
  }

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }
}
