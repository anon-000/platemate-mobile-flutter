///
/// Created by Sunil Kumar from Boiler plate
///
mixin Environment {
  static const String environment =
      String.fromEnvironment("env", defaultValue: 'dev');

  // static const String baseApiUrl = environment == 'prod'
  //     ? 'http://192.168.29.123:3030'
  //     : 'http://192.168.29.123:3030';

  /// home
  // static const String baseApiUrl = environment == 'prod'
  //     ? 'http://192.168.153.156:3030'
  //     : 'http://192.168.153.156:3030';

  //// my hotspot collage
  // static const String baseApiUrl = environment == 'prod'
  //     ? 'http://192.168.136.156:3030'
  //     : 'http://192.168.136.156:3030';



  /// office wifi
  static const String baseApiUrl = environment == 'prod'
      ? 'http://192.168.29.123:3030'
      : 'http://192.168.29.123:3030';

  // static const String baseApiUrl = environment == 'prod'
  //     ? 'http://192.168.136.156:3030'
  //     : 'http://192.168.136.156:3030';

  static const googleClientId = environment == 'prod'
      ? '1047854581243-s0re1r4vnt3lp6qubochtdgv2knv9sv5.apps.googleusercontent.com'
      : '1047854581243-s0re1r4vnt3lp6qubochtdgv2knv9sv5.apps.googleusercontent.com';

  static const fontFamily = 'Source Sans Pro';

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
