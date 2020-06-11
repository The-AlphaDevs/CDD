import 'package:flutter/material.dart';
import 'dart:io';
import 'image_storer.dart';
import 'result.dart';

class Predict extends StatelessWidget {
  static final obj = ImageStorer();
  final File cropimage = obj.getImage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Aatmarnirbhar Farmer'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height:400,
            width:420,
            margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: cropimage == null ? Container(child: Text("Please select an image first!")) : Image.file(cropimage)
      ),
      SizedBox(
            height: 60,
            width: 20,
          ),
      Container(
              color: Color(0xFFff7751),
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Know about the disease \n by clicking below!!",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Nunito',
                            color: Colors.white),
                        softWrap: false,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              ),

          SizedBox(
            height: 90,
            width: 20,
          ),

            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 60,
                width: 200,
                child: RaisedButton.icon(
                  label: Text(
                    "Predict",
                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800,
                            fontFamily: 'Nunito',
                            color: Colors.white),
                  ),
                  textColor: Colors.white,
                  icon: Icon(Icons.search, color: Colors.white),
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17)),
                  onPressed: () {
                    // pickImageFromGallery(ImageSource.gallery);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Result()));
                  },
                ),
              ),
            ],
          ),
        ],
      ), 
    );
  }
}

