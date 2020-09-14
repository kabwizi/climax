import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/location.dart';
import '../services/networking.dart';

const apiKey = 'c5cd38896b4d0d6b612aa99e7eb01c6f';
const url = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Location location = Location();
  Future<dynamic> updateUiByCityName(String nameCity) async {
    NetWorking netWorking =
        NetWorking('$url?q=$nameCity&appid=$apiKey&units=metric');
    var resultat = await netWorking.getCurrentWeather();
    return resultat;
  }

  Future<dynamic> getWeatherLocation() async {
    await location.getCurrentPosition();
    NetWorking netWorking = NetWorking(
        '$url?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var resultat = await netWorking.getCurrentWeather();
    print(resultat);
    return resultat;
  }

  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return FontAwesomeIcons.pooStorm;
    } else if (condition > 299 && condition <= 499) {
      return FontAwesomeIcons.cloudShowersHeavy;
    } else if (condition > 499 && condition <= 510) {
      return FontAwesomeIcons.cloudRain;
    } else if (condition > 510 && condition <= 520) {
      return FontAwesomeIcons.snowflake;
    } else if (condition > 520 && condition <= 599) {
      return FontAwesomeIcons.cloudShowersHeavy; //--
    } else if (condition > 599 && condition < 699) {
      return FontAwesomeIcons.snowflake; //--
    } else if (condition > 699 && condition <= 799) {
      return FontAwesomeIcons.smog;
    } else if (condition == 801) {
      return FontAwesomeIcons.cloudSun;
    } else if (condition == 802) {
      return FontAwesomeIcons.cloud;
    } else if (condition == 804 || condition == 803) {
      return FontAwesomeIcons.cloud;
    } else {
      return FontAwesomeIcons.sun;
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time ';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
