import 'package:flutter/material.dart';
import 'package:rss_reader/sidemenu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome!'),
      ),
      drawer: SideMenu(),
    );
  }
}
