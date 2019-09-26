import 'package:dio/dio.dart';

class DataService {

  dynamic getForcastFromService(String cityName) async{
    Response response;
    final String WEATHER_KEY = "c755af7334d048048b9192918190609";
    final String URL = "https://api-cdn.apixu.com/v1/forecast.json?key=$WEATHER_KEY&q=$cityName&days=7";
    try {
      response = await Dio().get(URL);
    } catch (e) {
      print(e);
    }

    return response;
  }
}