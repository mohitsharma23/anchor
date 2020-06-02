import 'package:flutter/material.dart';
import 'package:rss_reader/sidemenu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        bottomNavigationBar: Container(
          color: Colors.teal,
          child: TabBar(
            tabs: [
              Tab(icon: FaIcon(FontAwesomeIcons.solidUserCircle)),
              Tab(icon: FaIcon(FontAwesomeIcons.anchor))
            ],
            labelColor: Colors.white,
          ),
        ),
        body: TabBarView(children: [
          Column(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.teal, Colors.teal[300]],
              )),
              height: MediaQuery.of(context).size.height / 2,
              child: Center(child: CircleAvatar(radius: 80)),
            )
          ]),
          Center(child: Text('hello'))
        ]),
        drawer: SideMenu(),
      ),
    );
  }
}
