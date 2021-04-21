//11 June 2020
import 'package:flutter/material.dart';
// import 'Login-Register/login.dart';
//import 'Login-Register/signup;.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login-Register/bezierContainer.dart';
import 'Login-Register/login.dart';
// import 'root_page.dart';
// import 'package:flutter_fire_auth/services/authentication.dart';
import 'introslides.dart';
import 'package:flutter_fire_auth/globals.dart' as globals;

class WelcomePage2 extends StatefulWidget {
  final VoidCallback loginCallbackRegister;
  final VoidCallback loginCallback;
  final VoidCallback logoutCallback;
  // final BaseAuth auth;
  WelcomePage2(
      {Key key,
      this.title,
      this.loginCallbackRegister,
      this.loginCallback,
      this.logoutCallback})
      : super(key: key);

  final String title;

  @override
  _WelcomePage2State createState() => _WelcomePage2State();
}

class _WelcomePage2State extends State<WelcomePage2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PersistentBottomSheetController _sheetController;
  String _email;
  String _password;
  String _displayName;
  bool _loading = false;
  bool _autoValidate = false;
  String errorMsg = "";

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
                // Container(
                //   child: Stack(
                //     children: <Widget>[
                //       Positioned(
                //         top: -height * .15,
                //         right: -MediaQuery.of(context).size.width * .4,
                //         child: BezierContainer()),
                //       Positioned(
                //         right: 10,
                //         top: 10,
                //         child: IconButton(
                //           onPressed: () {
                //             Navigator.of(context).pop();
                //           },
                //           icon: Icon(
                //             Icons.close,
                //             size: 30.0,
                //             color: Colors.black,
                //           ),
                //         ),
                //       ),
                //       //Container
                //       //padding: EdgeInsets.symmetric(horizontal: 20),
                //       //child:
                //     ],
                //   ),
                //   height: 100,
                //   width: 50,
                // ),
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
                                  // Positioned(
                                  //   child: Align(
                                  //     child: Container(
                                  //       width: 130,
                                  //       height: 130,
                                  //       decoration: BoxDecoration(
                                  //           shape: BoxShape.circle,
                                  //           color: Theme.of(context).primaryColor),
                                  //     ),
                                  //     alignment: Alignment.center,
                                  //   ),
                                  // ),
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
                                                    .bodyText2,
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
                                  // Positioned(
                                  //   child: Align(
                                  //     child: Container(
                                  //       padding: EdgeInsets.only(top: 40, left: 28),
                                  //       width: 130,
                                  //       child: Text(
                                  //         "STER",
                                  //         style: TextStyle(
                                  //           fontSize: 40,
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.white,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     alignment: Alignment.center,
                                  //   ),
                                  // ),
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
                                  //color: Colors.amber,
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
          // Navigator.pushReplacementNamed(context, "/login");
          // Navigator.pushReplacementNamed(context, "/intro");
          widget.loginCallbackRegister();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IntroSlides(
                        logoutCallback: widget.logoutCallback,
                        loginCallback: widget.loginCallback,
                        loginCallbackRegister: widget.loginCallbackRegister,
                      )));
          globals.isLoggedIn = true;
          checkHistoryStatus(_email);
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => IntroS(auth: widget.auth)));
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

  outlineButton(void function()) {
    return OutlineButton(
      highlightedBorderColor: Colors.white,
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      highlightElevation: 0.0,
      splashColor: Colors.white,
      highlightColor: Theme.of(context).primaryColor,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      child: Text(
        "REGISTER",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
      onPressed: () {
        function();
      },
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        // Navigator.pushReplacementNamed(context, "/login");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage(
                    loginCallback: widget.loginCallback,
                    loginCallbackRegister: widget.loginCallbackRegister,
                    logoutCallback: widget.logoutCallback)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xffdf8e33).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color(0xfff7892b)),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        registerSheet();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
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

// Widget _verifyButton() {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => UserVerification()));
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.symmetric(vertical: 13),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(30)),
//           border: Border.all(color: Colors.white, width: 2),
//         ),
//         child: Text(
//           'Verify Kar Bhava',
//           style: TextStyle(fontSize: 20, color: Colors.white),
//         ),
//       ),
//     );
//   }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            // Text(
            //   'Quick login with Touch ID',
            //   style: TextStyle(color: Colors.white, fontSize: 17),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Icon(Icons.fingerprint, size: 90, color: Colors.white),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IntroSlides(
                            loginCallback: widget.loginCallback,
                            logoutCallback: widget.logoutCallback,
                            loginCallbackRegister:
                                widget.loginCallbackRegister)));
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Aatma',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'nirbhar',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: ' Far',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            TextSpan(
              text: 'mer',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xffe46b10)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 80,
              ),
              _submitButton(),
              SizedBox(
                height: 20,
              ),
              _signUpButton(),
              SizedBox(
                height: 20,
              ),
              //_verifyButton(),
              _label(),
            ],
          ),
        ),
      ),
    );
  } //build

}

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.icon,
      this.hint,
      this.obsecure = false,
      this.validator,
      this.onSaved});
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obsecure;
  final FormFieldValidator<String> validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        autofocus: true,
        obscureText: obsecure,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Color(0xffe46b10),
                width: 3,
              ),
            ),
            prefixIcon: Padding(
              child: IconTheme(
                data: IconThemeData(color: Colors.amber),
                child: icon,
              ),
              padding: EdgeInsets.only(left: 30, right: 10),
            )),
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
