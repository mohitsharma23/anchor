import 'package:flutter/material.dart';
import 'package:rss_reader/auth.dart';
import 'package:rss_reader/config.dart';

class SideMenu extends StatelessWidget {
  final AuthSerivce auth = new AuthSerivce();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        InkWell(
          onTap: () {
            if (ModalRoute.of(context).settings.name != PROFILE) {
              Navigator.pushReplacementNamed(context, PROFILE);
            }
          },
          child: DrawerHeader(
            padding: EdgeInsets.zero,
            child: Stack(
              children: <Widget>[
                CustomPaint(
                    size: MediaQuery.of(context).size, painter: CurvePainter()),
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                    child: CircleAvatar(radius: 40)) //profile image here
              ],
            ),
          ),
        ),
        Ink(
          color: ModalRoute.of(context).settings.name == HOME
              ? Colors.teal
              : Colors.transparent,
          child: ListTile(
            leading: Icon(
              Icons.home,
              color: ModalRoute.of(context).settings.name == HOME
                  ? Colors.white
                  : Colors.teal,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                  color: ModalRoute.of(context).settings.name == HOME
                      ? Colors.white
                      : Colors.black),
            ),
            onTap: () {
              if (ModalRoute.of(context).settings.name != HOME) {
                Navigator.pushReplacementNamed(context, HOME);
              }
            },
          ),
        ),
        Ink(
          color: ModalRoute.of(context).settings.name == SETTINGS
              ? Colors.teal
              : Colors.transparent,
          child: ListTile(
            leading: Icon(
              Icons.settings,
              color: ModalRoute.of(context).settings.name == SETTINGS
                  ? Colors.white
                  : Colors.teal,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                  color: ModalRoute.of(context).settings.name == SETTINGS
                      ? Colors.white
                      : Colors.black),
            ),
            onTap: () {
              if (ModalRoute.of(context).settings.name != SETTINGS) {
                Navigator.pushReplacementNamed(context, SETTINGS);
              }
            },
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.teal,
          ),
          title: Text('Logout'),
          onTap: () {
            auth.signOut().then((res) {
              if (res == true) {
                Navigator.pushReplacementNamed(context, LOGIN);
              }
            });
          },
        )
      ]),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.teal;
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, 0);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter customPainter) {
    return true;
  }
}
