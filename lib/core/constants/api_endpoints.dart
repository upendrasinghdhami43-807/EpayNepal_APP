/// Central registry of all API endpoint paths.
/// Replace [baseUrl] with actual server URL when integrating backend.
class ApiEndpoints {
  static const String baseUrl = 'https://api.epaynepal.com/api/v1';

  // Auth
  static const String register = '/auth/register';
  static const String sendOtp = '/auth/send-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String setPin = '/auth/set-pin';
  static const String verifyPin = '/auth/verify-pin';

  // User
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile/update';

  // Wallet
  static const String walletBalance = '/wallet/balance';
  static const String topUp = '/wallet/top-up';
  static const String withdraw = '/wallet/withdraw';
  static const String sendMoney = '/wallet/send';
  static const String requestMoney = '/wallet/request';

  // Transactions
  static const String transactions = '/transactions';
  static const String transactionDetail = '/transactions/{id}';

  // QR
  static const String generateQr = '/qr/generate';
  static const String resolveQr = '/qr/resolve';
  static const String confirmQrPayment = '/qr/confirm';

  // Bills
  static const String mobileRecharge = '/bills/mobile-recharge';
  static const String electricityBill = '/bills/electricity';
  static const String internetBill = '/bills/internet';
  static const String tvBill = '/bills/tv';
  static const String waterBill = '/bills/water';
  static const String govtPayment = '/bills/government';
  static const String educationFee = '/bills/education';

  // KYC
  static const String kycUpload = '/kyc/upload';
  static const String kycStatus = '/kyc/status';

  // Notifications
  static const String notifications = '/notifications';
  static const String markNotificationRead = '/notifications/{id}/read';
}
