
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';




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
  Weather weatherReport;


  Future<Position> getCurrentCord() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }


  Future<Weather> getData(double latitude, double longitude) async {
    WeatherFactory wf = WeatherFactory('3d45c6ea75793ed583d1664d77b8bb50');
    Weather w = await wf.currentWeatherByLocation(latitude, longitude);
    print(w);
    return w;

  }

  void initState() {
    super.initState();
    getCurrentCord().then((position) {
      getData(position.latitude, position.longitude).then((weather) {
        setState(() {
          lon = position.longitude;
          lat = position.latitude;
          weatherReport = weather;
        });
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