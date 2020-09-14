import 'package:http/http.dart' as http;
import 'dart:convert';

class NetWorking {
  String url;
  NetWorking(this.url);

  Future getCurrentWeather() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var reponseDecode = json.decode(response.body);
      return reponseDecode;
    } else {
      return print(response.statusCode);
    }
  }
}
