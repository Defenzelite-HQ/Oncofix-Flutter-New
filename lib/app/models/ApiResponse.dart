import 'dart:convert';

ApiResponse apiResponseModelFromJson(String str) => ApiResponse.fromJson(json.decode(str));

String apiResponseModelToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    this.status,
    this.message,
    this.validationError,
    this.data,
  });

  String? status;
  String? message;
  String? validationError;
  dynamic data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        status: json["status"] == null ? "error" : json["status"].toString(),
        message: json["message"] == null ? null : json["message"],
        validationError: json["errors"] == null ? null : json['errors'][json["errors"].keys.first].first,
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? "error" : status.toString(),
        "message": message == null ? null : message,
        "errors": validationError == null ? null : validationError,
        "data": data == null ? null : data,
      };

  ApiResponse copyWith({String? status, String? message, dynamic validationError, dynamic data}) {
    return ApiResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      validationError: validationError ?? this.validationError,
      data: data ?? this.data,
    );
  }

  ApiResponse withSuccess() {
    return ApiResponse(
      status: 'success',
      message: this.message,
      validationError: this.validationError,
      data: this.data,
    );
  }

  ApiResponse withMessage({String? message}) {
    return ApiResponse(
      status: 'success',
      message: message ?? this.message,
      validationError: this.validationError,
      data: this.data,
    );
  }

  bool isOk() => status == "success";

  bool isSuccessful() => status == 'success';

  bool hasError() => status == 'error';

  bool hasValidationErrors() => validationError != null;

  bool hasData() {
    if (data == null) {
      return false;
    } else if (data is List) {
      if (data.length > 0) return true;
    } else if (data is Map) {
      if (data.length > 0) return true;
    }

    return false;
  }
}
