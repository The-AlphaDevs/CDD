import 'profile.dart';
import 'profile_no_login.dart';
import 'package:flutter/material.dart';
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
  }

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
  }
}
