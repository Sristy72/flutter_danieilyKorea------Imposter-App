class ApiConstants {
  /// [Base Configuration]
  static const String baseDomain = 'http://10.10.5.33:5001';
  static const String baseUrl = '$baseDomain/api/v1';

  /// [Headers]
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
    ...defaultHeaders,
    'Authorization': 'Bearer $token',
  };

  static Map<String, String> get multipartHeaders => {
    'Accept': 'application/json',
    // Content-Type will be set automatically for multipart
  };

  /// [Endpoint Groups]
  static AuthEndpoints get auth => AuthEndpoints();
  static GameEndpoints get game => GameEndpoints();

}

/// [Authentication Endpoints]
class AuthEndpoints {
  static const String _base = '${ApiConstants.baseUrl}/auth';

  final String login = '$_base/login';
  final String register = '$_base/register';
  final String resetPass = '$_base/send-reset-otp';
  final String refreshToken = '$_base/refresh-token';
  final String otpVerify = '$_base/verify-reset-otp';
  final String otpVerifyRegister = '$_base/verify-otp';
  final String setNewPass = '$_base/reset-password';
}

class GameEndpoints{
  static const String _base = '${ApiConstants.baseUrl}';
  final String gameStart = '$_base/game/start-game';
}