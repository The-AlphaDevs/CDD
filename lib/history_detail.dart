import 'package:flutter/material.dart';
// import 'image_storer.dart';
// import 'dart:io';

class HistDetail extends StatefulWidget {
  @override
  _HistDetailState createState() => _HistDetailState();
}

class _HistDetailState extends State<HistDetail>{
  // static final obj = ImageStorer();
  // File cropimage = obj.getImage(); 
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
                    child: Image.asset("images/image1.jpg"),
                    //data:image/jpeg;base64,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
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
                                  fontSize: 18,
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
                                  fontSize: 15,
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
                                  fontSize: 18,
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
                                  fontSize: 15,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       height: 60,
                  //       width: 250,
                  //       child: RaisedButton.icon(
                  //         label: Text(
                  //           "Crops with  \nSimilar Diseases",
                  //           style: TextStyle(
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w800,
                  //               fontFamily: 'Nunito',
                  //               color: Colors.white),
                  //         ),
                  //         textColor: Colors.white,
                  //         icon: Icon(Icons.search, color: Colors.white),
                  //         color: Colors.amber,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(17)),
                  //         onPressed: () {
                  //           // pickImageFromGallery(ImageSource.gallery);
                  //           // Navigator.push(context,
                  //           //     MaterialPageRoute(builder: (context) => Predict(cropimage: _image)));
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(
                    height: 20,
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
  