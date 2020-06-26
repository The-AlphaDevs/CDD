import 'package:flutter/material.dart';
// import 'authentication.dart';
import 'homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_fire_auth/services/authentication.dart';
import 'welcome.dart';
import 'introslides.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_login_demo/utils/firebase_auth.dart';
// abstract class BaseAuth {

//   Future<FirebaseUser> getCurrentUser();

// }

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
  LOGGED_IN_REGISTER,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  // Future<FirebaseUser> getCurrentUser() async {
  //   FirebaseUser user = await _firebaseAuth.currentUser();
  //   return user;
  // }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
        print('Login Call Back User: $_userId');
        print("user id mila");
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
      print("logged in!");
    });
  }

  void loginCallbackRegister() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
        print('Login Call Back User: $_userId');
        print("user id mila");
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN_REGISTER;
      print("logged in by register!");
    });
  }
  // void homeCallback(){
  //    setState(() {
  //     authStatus = AuthStatus.LOGGED_IN;
    
  //   });
  // }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        print("Entered near welcome page");
        return new WelcomePage2(loginCallbackRegister: loginCallbackRegister,loginCallback: loginCallback, logoutCallback: logoutCallback);
        break;
      case AuthStatus.LOGGED_IN_REGISTER:
        print("Entered near intro page");
        return new IntroSlides(loginCallbackRegister: loginCallbackRegister,loginCallback: loginCallback, logoutCallback: logoutCallback);
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) 
        {
          print("Entered near home page");
          // return new Scafffold(
          //   body:Text("Home Page") ,
          // );
         return HomePage(
            // userId: _userId,
            // auth: widget.auth,
            // logoutCallback: logoutCallback,
            loginCallbackRegister: loginCallbackRegister,loginCallback: loginCallback, logoutCallback: logoutCallback
          ); 
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
