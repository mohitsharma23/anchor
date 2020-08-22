import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rss_reader/sidemenu.dart';
import 'package:rss_reader/util.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  UtilService _util = new UtilService();
  String url;
  List data;

  @override
  void initState() {
    super.initState();

    getFeedData();
  }

  Future<void> getFeedData() async {
    var response = await _util.readFeed();
    if (response == "Error") {
      var dataArr = await _util.getFeed();
      setState(() {
        data = dataArr;
      });
    } else {
      setState(() {
        data = response;
      });
    }
  }

  saveAnchor(url) async {
    var response = await _util.saveAnchor(url);
    if (response.runtimeType != String) {
      setState(() {
        data.addAll(response);
      });
    } else {
      return false;
    }
    return true;
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _addAnchor() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(Icons.close),
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Kindly enter the URL";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              url = value;
                            });
                          },
                          decoration: InputDecoration(hintText: 'google.com'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("Add Anchor"),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              // print(url);
                              bool check = saveAnchor(url);
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),
      body: this.data == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: getFeedData,
              child: ListView.builder(
                  itemCount: this.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      height: 100,
                      width: double.maxFinite,
                      child: InkWell(
                        onTap: () {
                          _launchURL(this.data[index].values.elementAt(1));
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: 2, color: Colors.teal))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    this.data[index].values.elementAt(0),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    child: Text(
                                      this.data[index].values.elementAt(2),
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                      textAlign: TextAlign.end,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
      floatingActionButton: FloatingActionButton(
          onPressed: _addAnchor, child: FaIcon(FontAwesomeIcons.anchor)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: SideMenu(),
    );
  }
}
