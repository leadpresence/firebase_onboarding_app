import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  String _token='';
  static const api_key = 'AIzaSyCKwoNcqSffbx8efXyV4nEnrs9U0p4_qJo';

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        Uri.parse('https://identitytoolkit..com/v1/accounts:$urlSegment?key=$api_key');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
    if (kDebugMode) {
      print(responseData);
    }
    _token = responseData['idToken'];
    if (kDebugMode) {
      print('************************' + _token.toString());
    }
    try {
      if (urlSegment == "signUp") {
        GetStorage().write("token", _token.toString());
      }
    } catch (e) {
      print(e);
    }
    print("true");
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> changePassword(String newPassword) async {
    print(newPassword);
    _token = GetStorage().read('token');
    final url =
    Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:update?key=$api_key');
    try {
      await http.post(
        url,
        body: json.encode(
          {
            'idToken': _token,
            'password': newPassword,
            'returnSecureToken': true,
          },
        ),
      );
    } catch (error) {
      throw error;
    }
  }
}