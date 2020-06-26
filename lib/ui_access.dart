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
        body:
        LayoutBuilder(
          builder:(BuildContext context, BoxConstraints constraints){
          return Column(
          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Flexible(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5.0,14.0,5.0,12.0),
                    child:Text("To enhance your app experience, Atmanirbhar Farmer would like to access your location",
                        textAlign:TextAlign.center,
                        style:TextStyle(fontSize:20,fontWeight: FontWeight.w900, fontFamily: 'Nunito')  // overflow: TextOverflow.ellipsis, softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // constraints.maxWidth < 500 ? 
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Center(
          //       child: Container(
          //         // padding: EdgeInsets.fromLTRB(6.0,7.0,6.0,7.0),
          //         child: Image.asset("images/image1.jpg", height: 400.0, width: 250.0),
          //     ),
          //     ), 
          //   ],
          // ) : 
          // Flexible(
          Flexible(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  // padding: EdgeInsets.fromLTRB(6.0,7.0,6.0,7.0),
                  child: Image.asset("images/image1.jpg", height:700, width:300),
                  // height: constraints.maxHeight*0.5,
                  // width: constraints.maxWidth*0.7,
              ),
              ), 
            ],
          ),
        ),
          Expanded(
            // margin: const EdgeInsets.only(top: 40.0),
            child:Align(
              child: Row(
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
            // Format buttons later.
            RaisedButton(
            child: Text("Skip"),
            textColor: Colors.white,
            color : Colors.amber,
            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17)),
            onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(logoutCallback: logoutCallback,loginCallback: loginCallback,loginCallbackRegister:loginCallbackRegister)),
            );
            },
            ),
            RaisedButton(
              child: Text("Allow"),
              color: Colors.amber,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17)),
              onPressed: () => [LocationService(),  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(logoutCallback: logoutCallback,loginCallback: loginCallback,loginCallbackRegister:loginCallbackRegister)))],
            ),
          ],
          ),
        ),
          ),
        ],
        );
          }
        ), 
    );
  }
}

// onPressed:()=>[rollDice(),rollDice2()],
