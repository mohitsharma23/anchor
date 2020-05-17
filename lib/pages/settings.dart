import 'package:flutter/material.dart';
import 'package:rss_reader/sidemenu.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'), centerTitle: true),
      body: Center(child: Text('Settings')),
      drawer: SideMenu(),
    );
  }
}
