import 'profile.dart';
import 'profile_no_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_fire_auth/services/authentication.dart';

class ProfileMain extends StatelessWidget{
    // bool isLoadong = true;
    //bool hasData = await getInfo();
    final VoidCallback logoutCallback;
    final VoidCallback loginCallbackRegister;
    final VoidCallback loginCallback;
    ProfileMain({this.logoutCallback, this.loginCallback, this.loginCallbackRegister}); 
    @override
    Widget build(BuildContext context){
    bool isLoading = true;
        return  FutureBuilder<FirebaseUser>(
            future: FirebaseAuth.instance.currentUser(),
            builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
                      if (snapshot.hasData){
                          //  FirebaseUser user = snapshot.data; // this is your user instance
                          // is because there is user already logged
                          print("Harami");
                          return ProfilePage(loginCallback: loginCallback, logoutCallback: logoutCallback, loginCallbackRegister: loginCallbackRegister);
                        }
                        else
                        {
                        // other way there is no user logged.
                          print("Nalayak");
                          return ProfileNoLogin(loginCallback: loginCallback, logoutCallback: logoutCallback, loginCallbackRegister: loginCallbackRegister);
                        }
            }
        );
          
      
    }
}