import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_reader/auth.dart';
import 'package:rss_reader/models/ThemeProvider.dart';
import 'package:rss_reader/pages/home.dart';
import 'package:rss_reader/pages/login.dart';
import 'package:rss_reader/pages/profile.dart';
import 'package:rss_reader/pages/settings.dart';
import 'package:rss_reader/pages/signup.dart';
import 'package:rss_reader/styles.dart';
import 'package:rss_reader/util.dart';
import './config.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthSerivce auth = new AuthSerivce();
  DarkThemeProvider themeProvider = new DarkThemeProvider();
  bool flag;

  @override
  void initState() {
    super.initState();
    getCurrentTheme();
    verifyUser();
  }

  getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.utilService.getTheme();
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
        : ChangeNotifierProvider(
            create: (_) {
              return themeProvider;
            },
            child: Consumer<DarkThemeProvider>(
              builder: (BuildContext context, value, Widget child) {
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: Styles.themeData(themeProvider.darkTheme, context),
                  initialRoute: flag ? HOME : LOGIN,
                  routes: {
                    LOGIN: (context) => Login(),
                    SIGNUP: (context) => Signup(),
                    HOME: (context) => Home(),
                    SETTINGS: (context) => Settings(),
                    PROFILE: (context) => Profile()
                  },
                );
              },
            ),
          );
  }
}
