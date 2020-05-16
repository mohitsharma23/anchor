import 'package:flutter/material.dart';
import 'package:rss_reader/auth.dart';
import 'package:rss_reader/pages/home.dart';
import 'package:rss_reader/pages/login.dart';
import 'package:rss_reader/pages/signup.dart';

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
    auth.verifyUser().then((val) => {
          setState(() {
            flag = val;
          })
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
            initialRoute: '/home', //flag ? '/home' : '/login',
            routes: {
              '/login': (context) => Login(),
              '/signup': (context) => Signup(),
              '/home': (context) => Home()
            },
          );
  }
}
