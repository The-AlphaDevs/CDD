import 'profile.dart';
import 'profile_no_login.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_fire_auth/services/authentication.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'root_page.dart';
import 'globals.dart' as globals;

class ProfileMain extends StatefulWidget {
  final VoidCallback logoutCallback;
  final VoidCallback loginCallbackRegister;
  final VoidCallback loginCallback;
  ProfileMain(
      {this.logoutCallback, this.loginCallback, this.loginCallbackRegister});

  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  bool isUser = false;
  @override
  void initState() {
    super.initState();
    // redirect();
  }

  // Future redirect() async {
  //   await getData();
  // }

  // Future getData() async {
  //   // SharedPreferences object = await SharedPreferences.getInstance();
  //   // bool isLoggedIn = object.getBool('isLoggedIn');
  //   // var user = await FirebaseAuth.instance.currentUser();
  //   if (globals.isLoggedIn) {
  //     setState(() {
  //       isUser = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (globals.isLoggedIn == true) {
      print("Profile");
      return ProfilePage(
          loginCallback: widget.loginCallback,
          logoutCallback: widget.logoutCallback,
          loginCallbackRegister: widget.loginCallbackRegister);
    } else {
      print("No login");
      return ProfileNoLogin(
          loginCallback: widget.loginCallback,
          logoutCallback: widget.logoutCallback,
          loginCallbackRegister: widget.loginCallbackRegister);
    }

    // @override
    // Widget build(BuildContext context){
    // // bool isLoading = true;
    //     return  FutureBuilder<FirebaseUser>(
    //         future: FirebaseAuth.instance.currentUser(),
    //         builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
    //                   if (snapshot.hasData){
    //                       //  FirebaseUser user = snapshot.data; // this is your user instance
    //                       // is because there is user already logged
    //                       print("Harami");
    //                       return ProfilePage(loginCallback: widget.loginCallback, logoutCallback: widget.logoutCallback, loginCallbackRegister: widget.loginCallbackRegister);
    //                     }
    //                     else
    //                     {
    //                     // other way there is no user logged.
    //                       print("Nalayak");
    //                       return ProfileNoLogin(loginCallback: widget.loginCallback, logoutCallback: widget.logoutCallback, loginCallbackRegister: widget.loginCallbackRegister);
    //                     }
    //         }
    //     );
  }
}

// class Notifier extends ChangeNotifier {}
