import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'location_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'predict.dart';
import 'image_storer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temperature;
  var description;
  var humidity;
  var now = new DateTime.now();
  File _image;
  //File weather_image ; 
  String weerImageString;
  final object = ImageStorer();
  final picker = ImagePicker();
  //bool _loading = false;

  Future<dynamic> getWeather() async {
    final obj = LocationService();
    final temp = await obj.getLocation();
    var lat = temp.latitude;
    var long = temp.longitude;
    http.Response response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=d3fbd88b43e95601432b581b0ad434c0&units=metric');
    var results = jsonDecode(response.body);
    setState(() {
      this.temperature = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.humidity = results['main']['humidity'];
      this.weerImageString = results['weather'][0]['icon'];
    });
    print(results);
    print(temperature);
    print(description);
    print(humidity);
    print(weerImageString);
    return results;
  }

  @override
  void initState() {
    super.initState();
    // _loading = true;
    this.getWeather();
  }

  Future getImage() async {
    // var image = await ImagePicker.pickImage(source: ImageSource.camera);
    // final pickedFile = await _picker.getImage(...);
    // final File file = File(pickedFile.path);
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image =  File(pickedFile.path);
      // ImageStorer(storedimage: _image);
      object.setImage(_image);
    });

  }

  pickImageFromGallery(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    // var image = await ImagePicker.pickImage(source: source);
    setState(() {
      _image = File(pickedFile.path);
      object.setImage(_image);
      // _loading = false;
      // print(_image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFF),
        appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Aatmanirbhar Farmer'),
        //backgroundColor: Colors.amber,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // padding: EdgeInsets.fromLTRB(13, 20, 20, 5),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xFF7edcb0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 20, 5),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        DateFormat("EEE, d MMMM").format(now) != null
                            ? "Today, " + DateFormat("EEE, d MMMM").format(now)
                            : "Loading..",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito',
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(110, 15, 0, 0),
                      //   child:Image.network(
                      //     "https://cdn.discordapp.com/attachments/705678935882596355/719792538856325120/1146869.png",
                      //     height: 70,
                      //     width: 60,
                      //     ),
                      // ),
                    ],
                  ),
                ),

                Divider(
                  color: Colors.black,
                  endIndent: 10.0,
                  indent: 10.0,
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                  child: Row(             
                    children: <Widget>[
                      Text(
                        temperature != null
                            ? temperature.toString() + "\u00B0C"
                            : "Loading..",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Nunito',
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 80,
                        width: 110,
                      ),
                      //  Padding(
                      //   padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      // LayoutBuilder(
                      //   builder:(BuildContext context, BoxConstraints constraints){
                      // ),
                      Flexible(
                      child:Container(
                        child: Image.asset(
                          "images/weather.png",
                          height: 68,
                          width: 56,
                          ),
                      ),
                      ),
                      // ),
                    ],
                  ),
                ),

                Divider(
                  color: Colors.black,
                  endIndent: 10.0,
                  indent: 10.0,
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                  child: Row(
                    children: <Widget>[
                      //weather_image ?
                      Image.network('http://openweathermap.org/img/w/$weerImageString.png',height: 45,width:45),
                      Text(
                        description != null
                            ? description.toString()[0].toUpperCase() +
                                description.toString().substring(1)
                            : "Loading..",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Nunito',
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 20, 5),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "images/humidity.png",
                        height: 45,
                        width: 45,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        humidity != null
                            ? humidity.toString() + "%"
                            : "Enable Location !",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Nunito',
                            color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 0,
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
                              padding: EdgeInsets.fromLTRB(2.0,2.0,2.0,2.0),
                              child:Text(
                                  "Want to know which disease\n your crop is affected by?",
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
              )),
          // SizedBox(
          //   height: 30,
          //   width: 50,
          // ),

          Flexible(
          child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children : <Widget>[ 
          Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[
            Container(
              height: 50,
              width: 200,
              child: RaisedButton.icon(
                label: Text(
                  "Open Camera",
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.white,
                icon: Icon(Icons.camera, color: Colors.white),
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17)),
                onPressed:  () async {
                  await getImage();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Predict()));
                },
              ),
            ),
          ]),
          SizedBox(
            height: 25,
            width: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,
                width: 200,
                child: RaisedButton.icon(
                  label: Text(
                    "Open Gallery",
                    style: TextStyle(fontSize: 18),
                  ),
                  textColor: Colors.white,
                  icon: Icon(Icons.image, color: Colors.white),
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17)),
                  onPressed: () async { 
                    await pickImageFromGallery(ImageSource.gallery);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Predict()));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
          ),
      ],
      ),
    );
  }
}






































































































































































































































































































































































































































































