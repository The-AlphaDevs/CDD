import 'package:flutter/material.dart';
import 'dart:io';
import 'image_storer.dart';
import 'result.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path; 

class Predict extends StatefulWidget {
  static final obj = ImageStorer();

  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  String _uploadedFileURL;
  final File cropimage = Predict.obj.getImage();
  
  Future uploadFile() async {
   StorageReference storageReference = FirebaseStorage.instance
       .ref()
       .child('Crops/${Path.basename(cropimage.path)}');
   StorageUploadTask uploadTask = storageReference.putFile(cropimage);
   await uploadTask.onComplete;
  //  print('File Uploaded');
   storageReference.getDownloadURL().then((fileURL) {
     setState(() {
       _uploadedFileURL = fileURL;
     });
   });  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Aatmarnirbhar Farmer'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child:  Column(
                children: <Widget>[
                  Container(
                    height:400,
                    width:420,
                    // margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
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
                              Flexible(
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:<Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(2.0,14.0,2.0,12.0),
                                    child:
                                    Text(
                                      "Know about the disease\nby clicking below!",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Nunito',
                                          color: Colors.white),
                                      softWrap: false,
                                      textAlign: TextAlign.center,
                                    ),
                                ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
                ),

                  SizedBox(
                    height: 70,
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
                            uploadFile();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Result()));
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


