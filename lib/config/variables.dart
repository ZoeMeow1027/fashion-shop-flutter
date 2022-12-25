import 'dart:ui';

class Variables {
  static String? paypalDomain = const bool.hasEnvironment("PAYPAL_URL")
      ? const String.fromEnvironment("PAYPAL_URL")
      : null;
  static String? payPalClientId = const bool.hasEnvironment("PAYPAL_CLIENTID")
      ? const String.fromEnvironment("PAYPAL_CLIENTID")
      : null;
  static String? payPalClientSecret =
      const bool.hasEnvironment("PAYPAL_CLIENTSECRET")
          ? const String.fromEnvironment("PAYPAL_CLIENTSECRET")
          : null;

  static const Color mainColor = Color.fromARGB(255, 219, 48, 34);
}
