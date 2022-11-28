import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/configurations.dart';
import '../model/dto/login_dto.dart';
import '../model/dto/register_dto.dart';
import '../model/user_profile.dart';

class UserAPI {
  static Future<bool> isLoggedIn(String token) async {
    final response = await http.get(
      Uri.parse('${Configurations.baseUrl}/api/users/profile/'),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    return (response.statusCode ~/ 100).round() == 2;
  }

  static Future<bool> login(LoginDTO loginDTO) async {
    try {
      if (!loginDTO.isValidate()) throw Exception("Missing data for login!");

      final response = await http.post(
        Uri.parse('${Configurations.baseUrl}/api/users/login/'),
        // Send authorization headers to the backend.
        body: loginDTO.toJson(),
      );

      // If status code is successful
      if ((response.statusCode ~/ 100).round() == 2) {
        // Write token to local storage
        SharedPreferences.getInstance().then(
          (value) => {
            value.setString(
                "tokenKey", "Bearer ${jsonDecode(response.body)["token"]}"),
          },
        );
        // Return true to UI
        return true;
      } else {
        // Return false
        return false;
      }
    } catch (ex) {
      // Any error cause return false.
      return false;
    }
  }

  static Future<UserProfile?> getProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('${Configurations.baseUrl}/api/users/profile/'),
        // Send authorization headers to the backend.
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      );
      if (response.statusCode ~/ 100 == 2) {
        return UserProfile.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Something went wrong with internet or token.");
      }
    } catch (ex) {
      return null;
    }
  }

  static Future<bool> register(RegisterDTO registerDTO) async {
    try {
      if (!registerDTO.isValidate()) throw Exception("Missing data for login!");

      final response = await http.post(
        Uri.parse('${Configurations.baseUrl}/api/users/register/'),
        // Send authorization headers to the backend.
        body: registerDTO.toJson(),
      );

      // If status code is successful
      if ((response.statusCode ~/ 100).round() == 2) {
        // Write token to local storage
        SharedPreferences.getInstance().then(
          (value) => {
            value.setString(
                "tokenKey", "Bearer ${jsonDecode(response.body)["token"]}"),
          },
        );
        // Return true to UI
        return true;
      } else {
        // Return false
        return false;
      }
    } catch (ex) {
      return false;
    }
  }
}
