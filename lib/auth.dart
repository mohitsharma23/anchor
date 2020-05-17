import 'dart:convert';

import 'package:rss_reader/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './config.dart';

class AuthSerivce {
  final String baseURL = API;

  Future<String> loginUser(UserModel user) async {
    Map map = {"email": user.email, "password": user.password};
    String body = json.encode(map);

    final res = await http.post(baseURL + "signin",
        headers: {'Content-Type': 'application/json'}, body: body);

    Map decode = json.decode(res.body);
    if (res.statusCode == 200) {
      final flag = await addTokenToSP(decode["token"]);
      if (flag) {
        return "Success";
      }
    }
    return decode["message"];
  }

  Future<String> signupUser(UserModel user) async {
    Map map = {
      "email": user.email,
      "name": user.fullName,
      "password": user.password
    };

    String body = json.encode(map);

    final res = await http.post(baseURL + "signup",
        headers: {'Content-Type': 'application/json'}, body: body);

    Map decode = json.decode(res.body);
    if (res.statusCode == 200) {
      final flag = await addTokenToSP(decode["token"]);
      if (flag) {
        return "Success";
      }
    }
    return decode["message"];
  }

  Future<bool> addTokenToSP(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    return true;
  }

  Future<bool> verifyUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      String token = prefs.getString("token");

      Map map = {token: token};
      String body = json.encode(map);

      final res = await http.post(this.baseURL + "verifyUser",
          headers: {'Content-Type': 'application/json'}, body: body);
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    return true;
  }
}
