import 'package:flutter/material.dart';
// import 'image_storer.dart';
// import 'dart:io';



class HistDetail extends StatefulWidget {
  final String url;
  final String disease;
  final String remedy;
  final String timestamp;
  HistDetail({this.url, this.disease, this.remedy, this.timestamp});
  
  @override
  _HistDetailState createState() => _HistDetailState();
}

class _HistDetailState extends State<HistDetail>{
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
                    // child: Image.network(widget.url),
                    decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff000000),
                      width: 6,
                    )),
                  child:   Image.network(widget.url,
                    width: 380,
                    height:350,
                    fit: BoxFit.cover),

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
                            Flexible(child:
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
                        ),
                          ],
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child:
                            Text(
                              widget.disease,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Nunito',
                                  color: Colors.green),
                              softWrap: false,
                              textAlign: TextAlign.center,
                            ),
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
                    height: 250,
                    width: 380,
                    child: 
                    SingleChildScrollView(child: 
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Remedies: \n",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(child: 
                            Text(
                              widget.remedy,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Nunito',
                                  color: Colors.green),
                              softWrap: true,
                              textAlign: TextAlign.justify,
                            ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
  