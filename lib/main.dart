import 'package:flutter/material.dart';
import 'package:rss_reader/auth.dart';
import 'package:rss_reader/pages/home.dart';
import 'package:rss_reader/pages/login.dart';
import 'package:rss_reader/pages/profile.dart';
import 'package:rss_reader/pages/settings.dart';
import 'package:rss_reader/pages/signup.dart';
import './config.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthSerivce auth = new AuthSerivce();
  bool flag;

  @override
  void initState() {
    super.initState();
    verifyUser();
  }

  verifyUser() async {
    bool val = await auth.verifyUser();
    setState(() {
      flag = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (flag == null)
        ? Container()
        : MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.teal,
            ),
            initialRoute: flag ? HOME : LOGIN,
            routes: {
              LOGIN: (context) => Login(),
              SIGNUP: (context) => Signup(),
              HOME: (context) => Home(),
              SETTINGS: (context) => Settings(),
              PROFILE: (context) => Profile()
            },
          );
  }
}
