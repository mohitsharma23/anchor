import 'package:flutter/material.dart';
import 'package:rss_reader/sidemenu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rss_reader/util.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UtilService util = new UtilService();
  String name = "", email = "";

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    Map user = await util.getProfileDetails();
    setState(() {
      name = user["name"];
      email = user["email"];
    });
  }

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
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.teal, Colors.teal[300]],
                  )),
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                      child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        "https://api.adorable.io/avatars/200/mohit.png"),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Text('NAME',
                      style: TextStyle(
                          color: Colors.teal[800],
                          letterSpacing: 1.5,
                          fontSize: 18,
                          fontWeight: FontWeight.w800)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: Text(this.name != "" ? this.name : "Loading",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Text('E-MAIL',
                      style: TextStyle(
                          color: Colors.teal[800],
                          letterSpacing: 1.5,
                          fontSize: 18,
                          fontWeight: FontWeight.w800)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: Text(this.email != "" ? this.email : "Loading",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ),
              ]),
          Center(child: Text('hello'))
        ]),
        drawer: SideMenu(),
      ),
    );
  }
}
