import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rss_reader/models/ThemeProvider.dart';
import 'package:rss_reader/sidemenu.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Dark Theme"),
            trailing: Checkbox(
                value: themeChange.darkTheme,
                onChanged: (bool value) {
                  themeChange.darkTheme = value;
                }),
          )
        ],
      ),
      drawer: SideMenu(),
    );
  }
}
