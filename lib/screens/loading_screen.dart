import 'package:flutter/material.dart';
import '../services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    geolocationAndData();
  }

  geolocationAndData() async {
    WeatherModel weatherModel = WeatherModel();
    var resultat = await weatherModel.getWeatherLocation();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LocationScreen(resultat)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitWave(
                size: 100.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 80.0,
              ),
              Text(
                "Waiting for location...",
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              )
            ]),
      ),
    );
  }
}
