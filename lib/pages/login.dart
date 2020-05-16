import 'package:flutter/material.dart';
import 'package:rss_reader/auth.dart';
import '../models/User.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final user = UserModel();
  final _formKey = GlobalKey<FormState>();
  AuthSerivce auth = new AuthSerivce();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void validateForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String res = await auth.loginUser(user);
      if (res == "Success") {
        Navigator.pushNamed(context, '/home');
        print('Home Page');
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 40, 0, 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Text('Welcome,',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                Text(
                  'sign in to continue',
                  style: TextStyle(
                      fontSize: 40, color: Colors.grey, letterSpacing: -1.5),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 15),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      user.email = value;
                    });
                  },
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 15),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      user.password = value;
                    });
                  },
                  decoration: InputDecoration(hintText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: RaisedButton(
                          onPressed: validateForm,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Sign In'),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Text('Don\'t have an account?',
                            style: TextStyle(color: Colors.grey)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
