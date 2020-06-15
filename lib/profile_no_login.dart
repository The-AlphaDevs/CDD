import 'package:flutter/material.dart';
// import 'package:flutter_fire_auth/utils/firebase_auth.dart';

class ProfileNoLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Aatmanirbhar Farmer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Please Log in!"),
            RaisedButton(
              child: Text("Go to Login Page"),
              onPressed: ()
              {
                Navigator.pushReplacementNamed(context, "/login");
              },
            )
          ],
        ),
      ),
    );
  }
}