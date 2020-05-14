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
    if (decode.containsKey("token")) {
      //add token to Shared Preferences
      return "Success";
    }
    return decode["message"];
  }
}
