import 'history.dart';
import 'profile_no_login.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'root_page.dart';
import 'globals.dart' as globals;

class HistoryMain extends StatefulWidget {
  final VoidCallback loginCallback;
  final VoidCallback loginCallbackRegister;
  final VoidCallback logoutCallback;
  HistoryMain(
      {this.loginCallback, this.logoutCallback, this.loginCallbackRegister});
  @override
  _HistoryMainState createState() => _HistoryMainState();
}

class _HistoryMainState extends State<HistoryMain> {
  bool isUser = false;

  RootPage obj = RootPage();
  @override
  void initState() {
    super.initState();
    //redirect();
  }

  // Future redirect() async {
  //   // await getData();
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
    if (globals.isLoggedIn) {
      print("History");
      return HistoryPage();
    } else {
      print("No login");
      return ProfileNoLogin(
          loginCallback: widget.loginCallback,
          logoutCallback: widget.logoutCallback,
          loginCallbackRegister: widget.loginCallbackRegister);
    }

    // return FutureBuilder<FirebaseUser>(
    //     future: FirebaseAuth.instance.currentUser(),
    //     builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
    //               if (snapshot.hasData){
    //               // FirebaseUser user = snapshot.data;
    //               // this is your user instance
    //               // is because there is user already logged
    //               // setState(() {
    //               //   isLoading = false;
    //               // });
    //                   print("History");
    //                   return HistoryPage();
    //               }
    //               else{
    //                 // other way there is no user logged.
    //                 // setState(() {
    //                 // isLoading = false;
    //                 // });
    //                 print("No login");
    //                 return ProfileNoLogin(loginCallback: widget.loginCallback, logoutCallback: widget.logoutCallback, loginCallbackRegister: widget.loginCallbackRegister);
    //               }
    //     }
    // );
  }
}

// class HistoryMain{
//    bool isUser = false;

//   HistoryMain(){
//     redirect();
//     }

//    void setValue(bool val){isUser = val;}

//    Future redirect() async {
//     await getData();
//     if(isUser)
//     // Navigator.pushReplacementNamed(context, "/history");
//     HistoryPage();
//     else
//     // Navigator.pushReplacementNamed(context, "/historyNoLogin");
//     ProfileNoLogin();
//   }

//   Future getData() async {
//     var user = await FirebaseAuth.instance.currentUser();
//     //print(user);
//     if (user != null){
//     setValue(true);
//     }
//   return isUser;
//   }
// }
