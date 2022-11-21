import 'dart:io';

import 'package:http/http.dart' as http;

class UserAPI {
  static Future<bool> isLoggedIn(String token) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/users/profile/'),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    return (response.statusCode ~/ 100).round() == 2;
  }
}
