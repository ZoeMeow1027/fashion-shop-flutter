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
    try {
      final response = await http.get(
        Uri.parse('${Configurations.baseUrl}/api/users/profile/'),
        // Send authorization headers to the backend.
        headers: {
          HttpHeaders.authorizationHeader: token,
        },
      );
      return (response.statusCode ~/ 100).round() == 2;
    } catch (ex) {
      return false;
    }
  }

  static Future<bool> login(LoginDTO loginDTO,
      {bool rememberLogin = true}) async {
    try {
      if (!loginDTO.isValidate()) throw Exception("Missing data for login!");

      final response = await http.post(
        Uri.parse('${Configurations.baseUrl}/api/users/login/'),
        // Send authorization headers to the backend.
        body: loginDTO.toJson(),
      );

      // If status code is successful
      if ((response.statusCode ~/ 100).round() == 2) {
        if (rememberLogin) {
          // Write token to local storage
          SharedPreferences.getInstance().then(
            (value) => {
              value.setString(
                  "tokenKey", "Bearer ${jsonDecode(response.body)["token"]}"),
            },
          );
        }
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

  static Future<void> updateProfile({
    required String token,
    required UserProfile profile,
  }) async {
    Map<String, dynamic> data = profile.toJson();
    data.addAll({
      "password": "",
    });

    final response = await http.put(
      Uri.parse('${Configurations.baseUrl}/api/users/profile/update/'),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      return Future.error(
          "Server has returned with code ${response.statusCode}.");
    }
  }

  static Future<void> changePassword({
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    // if (oldPassword.length < 6 || newPassword.length < 6) {
    //   return Future.error(
    //       "Your old password or new password must be at least 6 characters!");
    // }

    UserProfile? profile = await getProfile(token);
    if (profile == null) {
      return Future.error("Session has expired or no internet connection!");
    }

    if (!(await login(
      LoginDTO.from(username: profile.username, password: oldPassword),
      rememberLogin: false,
    ))) {
      return Future.error("Your old password is incorrect!");
    }

    Map<String, dynamic> data = profile.toJson();
    data.addAll({
      "password": newPassword,
    });

    final response = await http.put(
      Uri.parse('${Configurations.baseUrl}/api/users/profile/update/'),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      return Future.error(
          "Server has returned with code ${response.statusCode}.");
    }
  }
}
