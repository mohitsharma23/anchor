import 'package:flutter/material.dart';
import '../models/User.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final user = UserModel();
  final _formKey = GlobalKey<FormState>();

  void validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(user.username);
      print(user.password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      return 'Please enter username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      user.username = value;
                    });
                  },
                  decoration: InputDecoration(hintText: 'Username'),
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
