import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class CentralState extends ChangeNotifier  {
  List<String> _cities = [];
  String _city = "";

  List<String> get cities => _cities;

  String get cityName => _city;

  void set cityName(String city){
    _city = city;
    notifyListeners();
  }

  Future<void> loadCities() async {
    dynamic res = await loadAsset();
    Map<String, dynamic> jsonCities = json.decode(res.toString());
    jsonCities.forEach((String key, dynamic value){
        _cities = [..._cities, ...value];
    });
    notifyListeners();
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/data/countries.json');
  }


  Future<dynamic> authenticate(String username, String password) async {
    notifyListeners();

    final Map<String, String> _userCredentials = {};
    _userCredentials["username"] = username;
    _userCredentials["password"] = password;

    try {
      
    }
    catch(error){
      print("error");
      print(error);
    }

    notifyListeners();
    return {};
  }

}