import 'package:covid19/objects/CountrySearch.dart';
import 'package:covid19/objects/Dataloader.dart';
import 'package:covid19/objects/Worlddata.dart';
import 'package:covid19/pages/ShowList.dart';
import 'package:flutter/material.dart';

class Worldwide extends StatefulWidget {
  final List<Country> value;
  final Map<String, dynamic> info;
  final List<String> countries;
  final Map<String, Country> map;
  Worldwide({@required this.value, this.info, this.countries, this.map});

  @override
  _WorldwideState createState() => _WorldwideState();
}

class _WorldwideState extends State<Worldwide> {
  Router r = Router();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'COVID-19',
            style: TextStyle(color: Colors.white, fontSize: 35.0),
          ),
          actions: <Widget>[
            IconButton(
              iconSize: 30.0,
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CountrySearch(
                    countries: widget.countries,
                    map: widget.map,
                  ),
                );
              },
              color: Colors.white,
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return await Future.delayed(
                Duration(seconds: 10), r.route(context));
          },
          child: ShowList(
            value: widget.value,
            info: widget.info,
            countries: widget.countries,
            map: widget.map,
          ),
        ),
      ),
    );
  }
}
