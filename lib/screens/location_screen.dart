import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final meteoLocation;
  LocationScreen(this.meteoLocation);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  IconData weatherIconData;
  int temp;
  String name;
  String message;
  int humidity;
  double wind;
  String description;
  double feels_like;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    updateUi(widget.meteoLocation);
  }

  updateUi(var donnee) {
    print(donnee);
    setState(() {
      int w = donnee["weather"][0]["id"];
      description = donnee["weather"][0]["description"];

      humidity = donnee["main"]["humidity"];
      wind = donnee["wind"]["speed"];
      feels_like = donnee["main"]["feels_like"];
      weatherIconData = weatherModel.getWeatherIcon(w);
      var t = donnee["main"]["temp"];
      temp = t.toInt();
      message = weatherModel.getMessage(t.toInt());
      name = donnee["name"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomPaint(
          painter: BluePainter(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                topRowButton(context),
                cityAndDayWidget(),
                Expanded(
                  child: Icon(
                    weatherIconData,
                    size: 130,
                    color: Colors.white,
                  ),
                ),
                temperatureAndGretingWidget(),
                bottomInformation(),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$message in $name!",
                    textAlign: TextAlign.center,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column temperatureAndGretingWidget() {
    return Column(
      children: <Widget>[
        Text(
          '$temp°C',
          style: kTempTextStyle,
        ),
        Text(
          '${greating(date.hour)}',
          style: TextStyle(color: Colors.grey[600], fontSize: 20),
        ),
      ],
    );
  }

  Column cityAndDayWidget() {
    return Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
              fontSize: 27, fontWeight: FontWeight.w500, color: kBlackColor),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '${returnDayName(date.weekday)} ${date.hour}:${date.minute} ${date.hour > 12 ? "PM" : "AM"}',
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
        Text(
          description,
          style: TextStyle(color: kBlackColor, fontSize: 18),
        ),
      ],
    );
  }

  Padding bottomInformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          bottomCardInfo(
              iconData: FontAwesomeIcons.tint,
              text: "HUMIDITY",
              value: humidity.toString()),
          bottomDivider(),
          bottomCardInfo(
              iconData: FontAwesomeIcons.thermometerQuarter,
              text: "FEEL",
              value: feels_like.toString()),
          bottomDivider(),
          bottomCardInfo(
              iconData: FontAwesomeIcons.wind,
              text: "WIND",
              value: wind.toString()),
        ],
      ),
    );
  }

  Container bottomDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      color: Colors.grey[300],
      height: 35,
      width: 2,
    );
  }

  Column bottomCardInfo({IconData iconData, String text, String value}) {
    return Column(
      children: <Widget>[
        Icon(
          iconData,
          color: kBlackColor,
          size: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style:
              TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(
              color: kBlackColor, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }

  topRowButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(FontAwesomeIcons.locationArrow,
              size: 20.0, color: kBlackColor),
          onPressed: () {
            weatherModel.getWeatherLocation().then((onValue) {
              print(onValue);
              updateUi(onValue);
            });
          },
        ),
        IconButton(
          icon: Icon(FontAwesomeIcons.city, size: 20.0, color: kBlackColor),
          onPressed: () async {
            var entre = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => CityScreen()));
            if (entre != null) {
              var resultatNomCity =
                  await weatherModel.updateUiByCityName(entre);
              updateUi(resultatNomCity);
            }
          },
        ),
      ],
    );
  }

  greating(int hour) {
    if (hour > 0 && hour < 12) {
      return "Good morning";
    } else if (hour > 12 && hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good night";
    }
  }

  returnDayName(int day) {
    print(day);
    switch (day) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
    }
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = kWhiteColor;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, height * 0.2);

    // paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width * 0.51, height * 0.5);

    // Paint a curve from current position to bottom left of screen at width * 0.1
    ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * 0.1, height);

    // draw remaining line to bottom left side
    ovalPath.lineTo(0, height);

    // Close line to reset it back
    ovalPath.close();

    paint.color = Colors.white.withOpacity(0.3);
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
