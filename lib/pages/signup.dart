import 'package:flutter/material.dart';
import 'package:rss_reader/auth.dart';
import 'package:rss_reader/models/User.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String password;
  String confirmPass;
  final user = UserModel();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthSerivce auth = new AuthSerivce();

  void validateForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String res = await auth.signupUser(user);
      if (res == "Success") {
        //navigate to home page
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.teal[400],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 40, 0, 40),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Text('Signup,',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.white)),
                    Text(
                      'enter details',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.grey[300],
                          letterSpacing: -1.5),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    CustomTextFormField(
                      hintText: 'Full Name',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter Full name';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        setState(() {
                          user.fullName = value;
                        });
                      },
                      isPassword: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    CustomTextFormField(
                      hintText: 'Email',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        setState(() {
                          user.email = value;
                        });
                      },
                      isPassword: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    CustomTextFormField(
                      hintText: 'Password',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter password';
                        } else if (value.length < 6) {
                          return 'Password must be more than 6 characters';
                        }
                        return null;
                      },
                      onChange: (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                      isPassword: true,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    CustomTextFormField(
                      hintText: 'Confirm Password',
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Confirm Password';
                        } else if (password != value) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        setState(() {
                          user.password = value;
                        });
                      },
                      isPassword: true,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 20),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: RaisedButton(
                          onPressed: validateForm,
                          color: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Get Started'),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                          )),
                    )
                  ]),
            ),
          ),
        ));
  }
}

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final Function onChange;
  final bool isPassword;

  CustomTextFormField(
      {this.hintText,
      this.validator,
      this.onSaved,
      this.isPassword,
      this.onChange});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      validator: this.validator,
      onSaved: this.onSaved,
      onChanged: this.onChange,
      decoration: InputDecoration(
          hintText: this.hintText,
          hintStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.redAccent[700]),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent[700])),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent[700])),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
      obscureText: this.isPassword ? true : false,
    );
  }
}
