import 'package:flutter/material.dart';
import 'image_storer.dart';
import 'dart:io';

class Result extends StatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  static final obj = ImageStorer();
  File cropimage = obj.getImage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Aatmarnirbhar Farmer'),
        backgroundColor: Colors.amber,
      ),
      body:Container(
        child: Stack(
        children:<Widget>[ 
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:SingleChildScrollView(
                    child: Column(
                children: <Widget>[
                  Container(
                    height: 350,
                    width: 380,
                    margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                    child: Image.file(cropimage),
                  ),
                  SizedBox(
                    height: 40,
                    width: 20,
                  ),
                  Container(
                    color: Color(0xFFa4f5ff),
                    padding: EdgeInsets.all(30),
                    height: 150,
                    width: 380,
                    child: Column(
                      children: <Widget>[
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Predicted Disease: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Nunito',
                                  color: Colors.black),
                              softWrap: false,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Tomato_late_blight",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Nunito',
                                  color: Colors.green),
                              softWrap: false,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Confidence: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Nunito',
                                  color: Colors.black),
                              softWrap: false,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "98.0876%",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Nunito',
                                  color: Colors.green),
                              softWrap: false,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: 20,
                  ),
                  Container(
                    color: Color(0xFFa4f5ff),
                    padding: EdgeInsets.all(30),
                    height: 98,
                    width: 380,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Remedies: ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Nunito',
                                  color: Colors.black),
                              softWrap: false,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 250,
                        child: RaisedButton.icon(
                          label: Text(
                            "Crops with  \nSimilar Diseases",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
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
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => Predict(cropimage: _image)));
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 30,
                    width: 20,
                  ),

                ],
              ),
            ),
  
          ),
        ],
        ),
      ),
      );
      
  }
}
        