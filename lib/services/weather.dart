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

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
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
