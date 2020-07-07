import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:covid19/objects/Worlddata.dart';
import 'package:covid19/pages/Worldwide.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Router {
  List<String> _countries = [];
  HashMap<String, Country> _map = HashMap();

  Future<List<Country>> fetchCountry(http.Client client) async {
    final http.Response response =
        await client.get('https://corona.lmao.ninja/v2/countries?sort=deaths');
    final List responseJson = jsonDecode(response.body);
    return responseJson.map<Country>((json) => Country.fromJson(json)).toList();
  }

  Future<http.Response> fetchall(http.Client client) async {
    http.Response response =
        await client.get('https://corona.lmao.ninja/v2/all');
    return response;
  }

  FutureOr<dynamic> route(BuildContext context) {
    fetchCountry(http.Client()).then((value) {
      for (var i = 0; i < value.length; i++) {
        List l = value[i].name.toString().split(",");
        value[i].name = l[0];
        _countries.add(value[i].name.toString());
        _map[value[i].name.toString()] = value[i];
      }
      fetchall(http.Client()).then((response) {
        Map<String, dynamic> _info = jsonDecode(response.body);

        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Worldwide(
              value: value,
              info: _info,
              countries: _countries,
              map: _map,
            ),
          ),
        );
      });
    });
  }
}
