import 'history.dart';
import 'profile_no_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryMain extends StatelessWidget{

    @override
    Widget build(BuildContext context){
        return FutureBuilder<FirebaseUser>(
            future: FirebaseAuth.instance.currentUser(),
            builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
                      if (snapshot.hasData){
                           FirebaseUser user = snapshot.data; // this is your user instance
                           /// is because there is user already logged
                          return HistoryPage();
                        }
                         /// other way there is no user logged.
                        return ProfileNoLogin();
            }
          );
    }
}