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
  List anchors;

  @override
  void initState() {
    super.initState();
    getUserDetails();
    getAnchors();
  }

  getUserDetails() async {
    Map user = await util.getProfileDetails();
    setState(() {
      name = user["name"];
      email = user["email"];
    });
  }

  getAnchors() async {
    var anchorsArr = await util.getAnchors();
    setState(() {
      anchors = anchorsArr;
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
                        "https://api.adorable.io/avatars/200/" +
                            this.name +
                            ".png"),
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
          this.anchors == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                      child: Text('Your Anchors',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    Row(children: <Widget>[
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      )),
                      Text(' Swipe to Remove ',
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                      Expanded(
                          child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      )),
                    ]),
                    this.anchors.length == 0
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("No Anchors are present"),
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: this.anchors.length,
                              itemBuilder: (context, index) {
                                final item = this.anchors[index];
                                var anchor = item.split('/');
                                return Dismissible(
                                  key: Key(item),
                                  onDismissed: (direction) async {
                                    setState(() {
                                      anchors.removeAt(index);
                                    });
                                    String msg = await util.removeAnchor(item);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(msg),
                                    ));
                                  },
                                  background: Container(color: Colors.red),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide())),
                                    padding: EdgeInsets.all(2),
                                    child: ListTile(
                                      title: Text(
                                        anchor[0].substring(12),
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      leading: FaIcon(FontAwesomeIcons.anchor),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                )
        ]),
        drawer: SideMenu(),
      ),
    );
  }
}
