///
/// Created by Sunil Kumar from Boiler plate
///
mixin Environment {
  static const String environment =
      String.fromEnvironment("env", defaultValue: 'dev');

  static const String baseApiUrl = environment == 'prod'
      ? 'https://api.test.festabash.com'
      : 'https://api.test.festabash.com';

  static const googleClientId = environment == 'prod'
      ? '923972104763-02lsj48gvd91v4rh4ut82n095nprppap.apps.googleusercontent.com'
      : '923972104763-02lsj48gvd91v4rh4ut82n095nprppap.apps.googleusercontent.com';

  static const fontFamily = 'Manrope';

  static const mapApiKey = 'AIzaSyA0MFZxHOCAO0Suy9MRWS0wIg6_FFynHvg';

  static const razorPayName = "Vridoo";
  static const defaultCoordinates = [23.2599, 77.4126];

  static const razorPayKey = environment == 'prod'
      ? 'rzp_test_pC6qqqbP83w7bs'
      : 'rzp_test_pC6qqqbP83w7bs';
  static const otpLength = 6;

  static const razorPayKeySecret = 'RDgDRqnLU0JdfFjV5ZO6JTWc';
  static const termsUrl =
      'https://api.test.festabash.com/terms-and-conditions/';
  static const privacyUrl = 'https://api.test.festabash.com/privacy-policy/';
}
