import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  double lat;
  double lon;

  Future<Position> getPosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  getCurrentLat() async {

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position.latitude;

  }

  getCurrentLon() async {

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position.longitude;

  }


  Future<String> getData(double latitude, double longitude) async {
    WeatherFactory wf = WeatherFactory('3d45c6ea75793ed583d1664d77b8bb50');
    Weather w = await wf.currentWeatherByLocation(latitude, longitude);
    print(w);
    //return parsed['list'][0]['weather'][0]['description'];
  }

  void initState() {
    super.initState();
    getPosition().then((position) {
      setState(() {
        lon = position.longitude;
        lat = position.latitude;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
            appBar: AppBar(
                title: Text("Privacy Confirmation")
            ),
            body: Align(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Icon(
                        Icons.location_on, size:100, color:Colors.grey,
                    ),
                    //Text('$_weather'),
                    FlatButton(
                        onPressed: () {
                          getData(lat,lon);
                        },
                        color: Colors.blue,
                        child: Text("Get Current Location", style:TextStyle(color:Colors.white,fontSize: 20)),
                    )

                  ]),
            )
        )
    );
  }
}