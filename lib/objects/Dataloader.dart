import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:covid19/objects/Worlddata.dart';
import 'package:covid19/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Country>> fetchCountry(http.Client client) async {
  final http.Response response =
      await client.get('https://disease.sh/v3/covid-19/countries/?sort=deaths');
  final List responseJson = jsonDecode(response.body);
  return responseJson.map<Country>((json) => Country.fromJson(json)).toList();
}

Future<Map<String, dynamic>> fetchall(http.Client client) async {
  http.Response response =
      await client.get('https://disease.sh/v3/covid-19/all');
  return jsonDecode(response.body);
}

class Routing {
  List<String> _countries = [];
  HashMap<String, Country> _map = HashMap();
  Map<String, dynamic> _info = Map();
  List<Country> _value = [];

  FutureOr<dynamic> route(BuildContext context) {
    fetchCountry(http.Client()).then((value) async {
      for (var i = 0; i < value.length; i++) {
        List l = value[i].name.toString().split(",");
        value[i].name = l[0];
        _countries.add(value[i].name.toString());
        _map[value[i].name.toString()] = value[i];
      }
      _value = value;

      _info = await fetchall(http.Client());

      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Worldwide(
            value: _value,
            info: _info,
            countries: _countries,
            map: _map,
          ),
        ),
      );
    });
  }
}
