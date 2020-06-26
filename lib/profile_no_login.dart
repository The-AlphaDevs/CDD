import 'package:flutter/material.dart';
// import 'package:flutter_fire_auth/utils/firebase_auth.dart';
import 'Login-Register/login.dart';

class ProfileNoLogin extends StatelessWidget {
  final VoidCallback loginCallback;
  final VoidCallback loginCallbackRegister;
  final VoidCallback logoutCallback;

  ProfileNoLogin({this.loginCallback, this.loginCallbackRegister, this.logoutCallback});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Aatmanirbhar Farmer'),
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
            child:
            Text("Please Log In in order to \n access this amazing Feature!",textAlign: TextAlign.center ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22,))
            ),
      
            SizedBox(
              height: 30,
            ),
            Center(child:FlatButton(
              child: Text("Go to Login Page", style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold, fontSize: 20)),
              color: Colors.amber,
              padding: EdgeInsets.all(13.0),
               shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17)),
              
              onPressed: ()
              {
            Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage(loginCallback:loginCallback, loginCallbackRegister:loginCallbackRegister, logoutCallback: logoutCallback)));              },
              
            )
            ),
          ],
        ),
    );
  }
}