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
  String feedError;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getFeedData();
  }

  Future<void> refreshFeedData() async {
    var dataArr = await _util.getFeed();
    setState(() {
      data = dataArr;
    });
  }

  getFeedData() async {
    var response = await _util.readFeed();
    if (response == "Error") {
      refreshFeedData();
    } else {
      setState(() {
        data = response;
      });
    }
  }

  Future<String> saveAnchor(url) async {
    var response = await _util.saveAnchor(url);
    if (response.runtimeType != String) {
      setState(() {
        data.addAll(response);
      });
      return "Success";
    }
    return response;
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _addAnchor() {
    this.setState(() {
      feedError = null;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
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
                        !this.isLoading && this.feedError != null
                            ? Text(
                                this.feedError,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            child: isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : Text("Add Anchor"),
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      setState(() {
                                        isLoading = true;
                                      });
                                      // print(url);
                                      String res = await saveAnchor(url);
                                      if (res == "Success") {
                                        Navigator.of(context).pop();
                                      } else {
                                        this.setState(() {
                                          feedError = res;
                                        });
                                      }
                                      setState(() {
                                        isLoading = false;
                                      });
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
          : this.data.length == 0
              ? Center(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage('assets/Anchor.png')),
                    // Text('No Anchors are present')
                  ],
                ))
              : RefreshIndicator(
                  onRefresh: refreshFeedData,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                              width: 300,
                                              child: Text(
                                                this
                                                    .data[index]
                                                    .values
                                                    .elementAt(0),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          // Icon(Icons.star_border)
                                        ],
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
