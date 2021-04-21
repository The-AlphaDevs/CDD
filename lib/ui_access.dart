import 'package:flutter/material.dart';
import 'package:flutter_fire_auth/homepage.dart';
import 'location_service.dart';
import 'homepage.dart';

class UiAccess extends StatelessWidget{
  final VoidCallback logoutCallback;
  final VoidCallback loginCallbackRegister;
  final VoidCallback loginCallback;  
  UiAccess({this.logoutCallback,this.loginCallbackRegister,this.loginCallback});
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        title: const  Text("Aatmanirbhar Farmer"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical:8.0, horizontal: 10),
        child: Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:8.0, horizontal: 15),
              child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical:35, horizontal: 10),
                  child:Text("To enhance your app experience, Atmanirbhar Farmer would like to access your location",
                    softWrap: true,
                    textAlign:TextAlign.center,
                    style:TextStyle(fontSize:20, fontWeight: FontWeight.w500, fontFamily: 'Nunito'),
                    ),
                  ),
                SizedBox(height: 30,),
                Container(
                  height:260, 
                  child: Image.asset("images/image1.jpg", ),
                ),
                SizedBox(height: 60,),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                
                children: <Widget>[
                  RaisedButton(
                    child: Text("Skip"),
                    textColor: Colors.white,
                    color : Colors.amber,
                    shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                    onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(logoutCallback: logoutCallback,loginCallback: loginCallback,loginCallbackRegister:loginCallbackRegister)
                        ),
                      );
                    },
                  ),
                  
                  RaisedButton(
                    child: Text("Allow"),
                    color: Colors.amber,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17)),
                    onPressed: () => [
                      LocationService(),  
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(logoutCallback: logoutCallback,loginCallback: loginCallback,loginCallbackRegister:loginCallbackRegister)
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}