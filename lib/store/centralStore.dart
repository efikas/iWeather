import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:iweather/services/service.dart';

class CentralState extends ChangeNotifier  {
  List<String> _cities = [];
  Map<String,dynamic> _forcast = {
    "location": {
      "name": "Akure",
      "region": "Ondo",
      "country": "Nigeria",
      "lat": 7.25,
      "lon": 5.2,
      "tz_id": "Africa/Lagos",
      "localtime_epoch": 1568978885,
      "localtime": "2019-09-20 12:28"
    },
    "current": {
      "temp_c": 28,
      "temp_f": 78.8,
      "is_day": 1,
      "condition": {
        "text": "Partly cloudy",
        "icon": "//cdn.apixu.com/weather/64x64/day/116.png",
        "code": 1003
      },
      "wind_mph": 0,
      "wind_kph": 0,
      "wind_degree": 0,
      "wind_dir": "N",
      "pressure_mb": 1016,
      "pressure_in": 30.5,
      "precip_mm": 0.8,
      "precip_in": 0.03,
      "humidity": 79,
      "cloud": 50,
      "feelslike_c": 28.5,
      "feelslike_f": 83.2,
      "vis_km": 10,
      "vis_miles": 6,
      "uv": 7,
      "gust_mph": 4.9,
      "gust_kph": 7.9
    },
    "forecast": {
      "forecastday": null
    }
  };
  String _city = "";

  List<String> get cities => _cities;
  Map<String,dynamic> get forcast => _forcast;

  String get cityName => _city;

  void set cityName(String city){
    _city = city;
    notifyListeners();
  }

  Future<void> loadCities() async {
    dynamic res = await loadAsset();
    Map<String, dynamic> jsonCities = json.decode(res.toString());
    jsonCities.forEach((String key, dynamic value){
        _cities = Set.of([..._cities, ...value]).cast<String>().toList(); //remove duplicate from list
    });
    notifyListeners();
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/data/countries.json');
  }


  void getForcast(String city) async {
    DataService _service = new DataService();

    dynamic response = await _service.getForcastFromService(city);

    _forcast = json.decode(response.toString());
    notifyListeners();
  }

}