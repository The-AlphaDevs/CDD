//11 June 2020
import 'package:flutter/material.dart';
import 'utils/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bezierContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire_auth/introslides.dart';
import 'package:flutter_fire_auth/welcome.dart';
import 'package:flutter_fire_auth/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_fire_auth/globals.dart' as globals;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback loginCallback;
  final VoidCallback loginCallbackRegister;
  final VoidCallback logoutCallback;
  LoginPage(
      {this.loginCallback, this.loginCallbackRegister, this.logoutCallback});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _sheetController;
  String _email;
  String _password;
  String _displayName;
  bool _loading = false;
  bool _autoValidate = false;
  String errorMsg = "";

  void checkHistoryStatus(String emailID) {
    var userQuery = Firestore.instance
        .collection('users')
        .document(emailID)
        .collection('History')
        .orderBy('Time', descending: true);

    userQuery.getDocuments().then((data) {
      if (data.documents.length > 0) {
        globals.hasHistory = true;
      } else {
        globals.hasHistory = false;
      }
    });
  }

  void registerSheet() {
    final height = MediaQuery.of(context).size.height;
    Color primaryColor = Colors.amber;
    _sheetController =
        _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return DecoratedBox(
        decoration: BoxDecoration(color: primaryColor),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
          child: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  height: height,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        right: 10,
                        top: 10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                          top: -height * .15,
                          right: -MediaQuery.of(context).size.width * .4,
                          child: BezierContainer()),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                            child: Form(
                          child: Column(children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 40, 0, 0),
                                      child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              text: 'Aatma',
                                              style: GoogleFonts.portLligatSans(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                                fontSize: 50,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xffe46b10),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: 'nirbhar',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 50),
                                                ),
                                                TextSpan(
                                                  text: '\nFar',
                                                  style: TextStyle(
                                                      color: Color(0xffe46b10),
                                                      fontSize: 50),
                                                ),
                                                TextSpan(
                                                  text: 'mer',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 50),
                                                ),
                                              ])),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                  top: 100,
                                ),
                                child: CustomTextField(
                                  icon: Icon(Icons.account_circle),
                                  hint: "DISPLAY NAME",
                                  validator: (input) =>
                                      input.isEmpty ? "*Required" : null,
                                  onSaved: (input) => _displayName = input,
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                ),
                                child: CustomTextField(
                                  icon: Icon(Icons.email),
                                  hint: "EMAIL",
                                  onSaved: (input) {
                                    _email = input;
                                  },
                                  validator: emailValidator,
                                )),
                            Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: CustomTextField(
                                  icon: Icon(Icons.lock),
                                  obsecure: true,
                                  onSaved: (input) => _password = input,
                                  validator: (input) =>
                                      input.isEmpty ? "*Required" : null,
                                  hint: "PASSWORD",
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 30,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: _loading
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              primaryColor),
                                    )
                                  : Container(
                                      child: filledButton(
                                          "REGISTER",
                                          Colors.white,
                                          primaryColor,
                                          primaryColor,
                                          Colors.white,
                                          _validateRegisterInput),
                                      height: 50,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ]),
                          key: _formKey,
                          autovalidate: _autoValidate,
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height / 1.1,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
        ),
      );
    });
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Required';
    if (!regex.hasMatch(value))
      return '*Enter a valid email';
    else
      return null;
  }

  Widget filledButton(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor, void function()) {
    return RaisedButton(
      highlightElevation: 0.0,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
        //border
      ),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
      ),
      onPressed: () {
        function();
      },
    );
  }

  void _validateRegisterInput() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      _sheetController.setState(() {
        _loading = true;
      });
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password))
            .user;
        UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = _displayName;
        user.updateProfile(userUpdateInfo).then((onValue) {
          widget.loginCallbackRegister();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IntroSlides(
                      logoutCallback: widget.logoutCallback,
                      loginCallback: widget.loginCallback,
                      loginCallbackRegister: widget.loginCallbackRegister)));

          globals.isLoggedIn = true;
          globals.hasHistory = false;

          Firestore.instance.collection('users').document(_email).setData(
              {'email': _email, 'displayName': _displayName}).then((onValue) {
            _sheetController.setState(() {
              _loading = false;
            });
          });
        });
      } catch (error) {
        switch (error.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
            {
              _sheetController.setState(() {
                errorMsg = "This email is already in use.";
                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;
          case "ERROR_WEAK_PASSWORD":
            {
              _sheetController.setState(() {
                errorMsg = "The password must be 6 characters long or more.";
                _loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            }
            break;
          default:
            {
              _sheetController.setState(() {
                errorMsg = "";
              });
            }
        }
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  Widget buildTitleWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Aatma',
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: Color(0xffe46b10),
              ),
              children: [
                TextSpan(
                  text: 'nirbhar',
                  style: TextStyle(color: Colors.black, fontSize: 50),
                ),
                TextSpan(
                  text: '\nFar',
                  style: TextStyle(color: Color(0xffe46b10), fontSize: 50),
                ),
                TextSpan(
                  text: 'mer',
                  style: TextStyle(color: Colors.black, fontSize: 50),
                ),
              ])),
    );
  }

  Widget buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildTitleWidget(),
                      SizedBox(height: 80.0),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(hintText: "Enter email"),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Enter password"),
                      ),
                      SizedBox(height: 50.0),
                      buildEmailLoginButton(context),
                      SizedBox(height: 15.0),
                      buildDivider(),
                      SizedBox(height: 15.0),
                      buildGoogleLoginButton(context),
                      SizedBox(height: 80.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Don't have an account ?",
                            style: TextStyle(fontFamily: 'Montserrat'),
                          ),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () {
                              registerSheet();
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildGoogleLoginButton(BuildContext context) {
    return Container(
                      height: 40.0,
                      width: 270,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20.0),
                        ),
                      child: RaisedButton.icon(
                        elevation: 0,
                        icon: FaIcon(
                          FontAwesomeIcons.google,
                          size: 18,
                        ),
                        highlightColor: Colors.amber,
                        color: Colors.amber,
                        shape: StadiumBorder(),
                        onPressed: () async {
                            bool res = await AuthProvider().loginWithGoogle();
                            if (!res)
                              print("Error logging in with Google");
                            else {
                              //Redirect
                              widget.loginCallbackRegister();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IntroSlides(
                                    logoutCallback:
                                        widget.logoutCallback,
                                    loginCallback:
                                        widget.loginCallback,
                                    loginCallbackRegister: widget
                                        .loginCallbackRegister))); // IntroSlides();
                              globals.isLoggedIn = true;
                              SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                              prefs.setBool('isLoggedIn', true);
                            }
                          },
                        label: Text(
                                "Login with Google",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
                              ),

                      ),
                    );
  }

  Container buildEmailLoginButton(BuildContext context) {
    return Container(
                      height: 40.0,
                      width: 270,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20.0),
                        ),
                      child: RaisedButton(
                        elevation: 0,
                        highlightColor: Colors.amber,
                        color: Colors.amber,
                        shape: StadiumBorder(),
                        onPressed: () async {
                          if (_emailController.text.isEmpty ||
                              _passwordController.text.isEmpty) {
                            print("Email and password cannot be empty");
                            return;
                          }
                          bool res = await AuthProvider()
                              .signInWithEmail(_emailController.text,_passwordController.text);
                          if (!res) {
                            print("Login failed");
                          } else {
                            //Redirect
                            widget.loginCallback();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                    logoutCallback:
                                        widget.logoutCallback,
                                    loginCallback:
                                        widget.loginCallback,
                                    loginCallbackRegister: widget
                                        .loginCallbackRegister)));
                            globals.isLoggedIn = true;
                            checkHistoryStatus(_emailController.text);
                            SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                            prefs.setBool('isLoggedIn', true);
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
                        ),

                      ),
                    );
  }
}
