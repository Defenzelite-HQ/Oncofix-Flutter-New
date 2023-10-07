import '../../../../models/ApiResponse.dart';
import '../../../../models/UserModel.dart';

class AuthData {
  /// Create UserModel object
  static UserModel _userObj = UserModel(
    id: 1,
    name: "Mayank Sarathe",
    email: "admin@test.com",
    phone: "8305546538",
    avatar: "https://random.imagecdn.app/500/500",
    gender: "male",
  );

  /// Login Responses
  static ApiResponse get loginError => ApiResponse(
        status: "error",
        message: "Credentials do not match in our records.",
        data: null,
      );

  static ApiResponse get loginSuccess => ApiResponse(
        status: "success",
        message: "Logged in successfully.",
        data: {
          "user": _userObj.toJson(),
          "token": "some_random_string_as_token"
        },
      );

  static ApiResponse get loginSuccessOtp => ApiResponse(
        status: "success",
        message: "OTP Sent successfully.",
        data: "1234",
      );

  /// Register responses
  static ApiResponse get registerSuccess => ApiResponse(
        status: "success",
        message: "Welcome aboard! You are now registered with us.",
      );

  /// Get The User Data
  static ApiResponse get getUserSuccess => ApiResponse(
        status: "success",
        message: "Got the user.",
        data: _userObj.toJson(),
      );

  /// Logout response
  static ApiResponse get logoutSuccess =>
      ApiResponse(status: "success", message: "You are logged out");
}
