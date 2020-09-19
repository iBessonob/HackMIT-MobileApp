import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:Vacuate/Custom/page_title.dart';
import 'package:Vacuate/constants.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Vacuate/Services/UserAuthProvider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _userEmail = ''.trim();
  String _userPassword = ''.trim();
  bool _autoValidate = false;

  String validatePassword(String value) {
    if (value.isEmpty)
      return "Password can't be empty";
    else if (value.length < 8)
      return "Password can't be less than 8 chars";
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty)
      return "Email can't be empty";
    else if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void navToSignup() {
    print("Nav to Signup");
  }

  // void login() {
  //   print("logging in");
  // }

  @override
  Widget build(BuildContext context) {
    var userAuth = Provider.of<UserAuthProvider>(context);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            // Header Top Page
            children: [
              PageTitle(
                title: "Vacuate",
              ),

              // Login Title
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Form(
                autovalidate: _autoValidate,
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.topLeft,
                      child: Text("Login", style: subTextStyle),
                    ),

                    // Email Form
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              child:
                                  Text("Email: ", style: standardWhiteTitle)),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              child: TextFormField(
                                onSaved: (value) {
                                  _userEmail = value;
                                },
                                validator: validateEmail,
                                // controller: emailController,
                                decoration: InputDecoration(
                                    hintText: 'Enter Email',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff707070)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff707070)),
                                    )),
                                style: TextStyle(color: titleColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Password Input
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                              child: Text("Password: ",
                                  style: standardWhiteTitle)),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              child: TextFormField(
                                onSaved: (value) {
                                  _userPassword = value;
                                },
                                validator: validatePassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff707070)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xff707070)),
                                    )),
                                style: TextStyle(color: titleColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Login Button
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              ButtonTheme(
                height: 50,
                minWidth: 120,
                child: FlatButton(
                  onPressed: () async {
                    final isValid = _formKey.currentState.validate();
                    FocusScope.of(context).unfocus();
                    if (isValid) {
                      _formKey.currentState.save();
                      var result =
                          await userAuth.signIn(_userEmail, _userPassword);
                      if (result == "success") {
                        print("tototot");
                        Navigator.of(context).pushNamed('/home_screen');
                      }
                    }
                  },
                  color: purpleColor,
                  textColor: Colors.white,
                  child: Text(
                    "Log in",
                    style: standardWhiteDetail,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: finePurpleText,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      child: Text("Sign Up", style: fineBlueText),
                      onTap: this.navToSignup,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
