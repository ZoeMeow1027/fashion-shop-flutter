import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fashionshop/model/user_profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAPI {
  static const String _baseUrl = "http://127.0.0.1:8000";

  static Future<bool> isLoggedIn(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/users/profile/'),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
    return (response.statusCode ~/ 100).round() == 2;
  }

  static Future<bool> login(String user, String pass) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/users/login/'),
        // Send authorization headers to the backend.
        body: {
          "username": user,
          "password": pass,
        },
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
        Uri.parse('$_baseUrl/api/users/profile/'),
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
}