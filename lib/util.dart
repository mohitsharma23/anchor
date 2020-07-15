import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './config.dart';

class UtilService {
  final String baseURL = API;

  Future<Map> getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map map = {
      "email": prefs.getString("email"),
      "name": prefs.getString("name"),
    };

    return map;
  }

  Future<String> saveAnchor(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    Map map = {"email": email, "url": url};
    String body = json.encode(map);

    final res = await http.post(this.baseURL + "addanchor",
        headers: {'Content-Type': 'application/json'}, body: body);

    Map decode = json.decode(res.body);
    if (res.statusCode == 200) {
      return "Success";
    }
    return decode["message"];
  }

  Future<dynamic> getAnchors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    Map map = {"email": email};
    String body = json.encode(map);

    final res = await http.post(this.baseURL + "getanchors",
        headers: {'Content-Type': 'application/json'}, body: body);

    var decode = json.decode(res.body);
    if (res.statusCode == 200) {
      // decode.forEach((item) => print(item.values.elementAt(0)));
      return decode;
    }
    return decode["message"];
  }
}
