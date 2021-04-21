import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'globals.dart';
import 'predict.dart';
import 'image_storer.dart';
import 'location_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temperature;
  var description;
  var humidity;
  File _image;
  bool isLoading=true;
  String weerImageString;
  final object = ImageStorer();
  final picker = ImagePicker();

  Future<dynamic> getWeather() async {
    isLoading = true;
    final obj = LocationService();
    final temp = await obj.getLocation();
    var lat = temp.latitude;
    var long = temp.longitude;
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=d3fbd88b43e95601432b581b0ad434c0&units=metric');
    var results = jsonDecode(response.body);
    setState(() {
      this.temperature = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.humidity = results['main']['humidity'];
      this.weerImageString = results['weather'][0]['icon'];
      isLoading = false;
    });
    print(results);
    return results;
  }

  @override
  void initState() {
    super.initState();
    isLoading = true;
    this.getWeather();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
      object.setImage(_image);
    });
  }

  pickImageFromGallery(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _image = File(pickedFile.path);
      object.setImage(_image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Aatmanirbhar Farmer'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10.0, vertical:8),
        child: Column(
          children: <Widget>[
            buildheadingDate(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildTemperatureCard(),
                SizedBox(width:5),
                buildHumidityCard(),
              ],
            ),
            SizedBox(height: 15),
            Divider(thickness: 1,),
            SizedBox(height: 15),
            Card(
              color: Color(0xFFff7751),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical:30, horizontal: 8),
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Want to know which disease\n your crop is affected by?",
                          style: GoogleFonts.getFont(
                            'Roboto',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                          softWrap: false,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height:20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildCameraCard(context),
                            buildGalleryCard(context),
                            ],
                          ),
                        ],
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

  Card buildGalleryCard(BuildContext context) {
    return Card(
            child: InkWell(
              onTap: () async {
                await pickImageFromGallery(ImageSource.gallery);
                Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => Predict()));
                },
              child: Padding(
                padding: EdgeInsets.fromLTRB(2,5,2,2),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                    'images/Open-Gallery.jpeg',
                    height: 150,
                    alignment: Alignment.topCenter,
                    ),
                    
                    Text(
                      "Open Gallery",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height:8),
                      ],
                    ),
                  ),
                ),
              );
  }

  Card buildCameraCard(BuildContext context) {
    return Card(
            child: InkWell(
              onTap: () async {
                await getImage();
                  Navigator.push( context,
                      MaterialPageRoute(
                        builder: (context) => Predict()));
                },
              child: Padding(
                padding: EdgeInsets.fromLTRB(2,5,2,2),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                    'images/Open-Camera.jpeg',
                    height: 150,
                    alignment: Alignment.topCenter,
                    ),
                    
                    Text(
                      "Open Camera",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height:8),
                  ],
                ),
              ),
            ),
          );
  }

  Card buildHumidityCard() {
    return Card(
            color: Color(0xFF7edcb0),
            child: InkWell(
                onTap: ()=>print("Tapped on Humidity Card"),
                splashColor: Colors.white70,
                child: Container(
                width: 160,
                height: 150,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:15, vertical:18),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "images/humidity.png",
                        height: 40,
                        ),
                      SizedBox(height:12),
                      Text(
                        "Humidity",
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                        textAlign: TextAlign.center,
                        ),
                      Text(
                        humidity != null
                          ? humidity.toString() + "%"
                          : "Loading..",
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                        textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
  }

  Card buildTemperatureCard() {
    return Card(
            color: Color(0xFF7edcb0),
            child: InkWell(
                onTap: ()=>print("Tapped on Temperature Card"),
                splashColor: Colors.white70,
                child: Container(
                width: 160,
                height: 150,
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal:10, vertical:18),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: isLoading || temperature == null ?
                        Image.asset(
                          'images/weather.png',
                          height: 40,
                        )
                        :
                        Image.network(
                          'https://openweathermap.org/img/w/$weerImageString.png',
                        ),
                      ),
                    isLoading || temperature == null ? SizedBox(height:12) : Container(),
                    Text(
                      description != null
                        ? description.toString()[0].toUpperCase() +
                            description.toString().substring(1)
                        : "Loading..",
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                        ),
                      textAlign: TextAlign.center,
                      ),
                    Text(
                      temperature != null
                          ? temperature.toString() + degreeCelsius
                          : "Loading..",
                      style: GoogleFonts.getFont(
                          'Nunito',
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                      textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Padding buildheadingDate() {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal:30, vertical:10),
            child: Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: GoogleFonts.getFont(
                'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
                decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
            ),
          );
  }
}
