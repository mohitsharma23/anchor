import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
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

  Future<dynamic> saveAnchor(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    Map map = {"email": email, "url": url};
    String body = json.encode(map);

    final res = await http.post(this.baseURL + "addanchor",
        headers: {'Content-Type': 'application/json'}, body: body);

    if (res.statusCode != 404) {
      var decode = json.decode(res.body);
      if (res.statusCode == 200) {
        appendToFile(json.encode(decode));
        return decode;
      }
      return decode["message"];
    }
    return "Error in fetching";
  }

  Future<dynamic> getFeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    Map map = {"email": email};
    String body = json.encode(map);

    final res = await http.post(this.baseURL + "getfeed",
        headers: {'Content-Type': 'application/json'}, body: body);

    if (res.statusCode != 404) {
      var decode = json.decode(res.body);
      if (res.statusCode == 200) {
        // decode.forEach((item) => print(item.values.elementAt(0)));
        writeToFile(json.encode(decode));
        return decode;
      }
      return decode["message"];
    }
    return "Error in fetching";
  }

  Future<dynamic> getAnchors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    Map map = {"email": email};
    String body = json.encode(map);

    final res = await http.post(this.baseURL + "getanchors",
        headers: {'Content-Type': 'application/json'}, body: body);

    if (res.statusCode != 404) {
      var decode = json.decode(res.body);
      if (res.statusCode == 200) {
        // decode.forEach((item) => print(item.values.elementAt(0)));
        return decode;
      }
      return decode["message"];
    }
    return "Error in fetching";
  }

  Future<dynamic> removeAnchor(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString("email");
    Map map = {"email": email, "url": url};
    String body = json.encode(map);

    final res = await http.post(this.baseURL + "removeanchor",
        headers: {'Content-Type': 'application/json'}, body: body);
    if (res.statusCode != 404) {
      var decode = json.decode(res.body);
      if (res.statusCode == 200) {
        // decode.forEach((item) => print(item.values.elementAt(0)));
        removeFile();
        return decode["message"];
      }
      return decode["message"];
    }
    return "Error in fetching";
  }

//Cache Test

  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/feed.txt');
  }

  Future<File> writeToFile(String feed) async {
    final file = await _localFile;
    return file.writeAsString(feed);
  }

  Future<File> appendToFile(String newFeed) async {
    final file = await _localFile;
    return file.writeAsString(newFeed, mode: FileMode.append);
  }

  Future<dynamic> readFeed() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();

      return json.decode(contents);
    } catch (e) {
      return "Error";
    }
  }

  void removeFile() async {
    final file = await _localFile;
    file.delete();
  }
}
