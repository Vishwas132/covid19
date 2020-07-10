import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19/objects/Worlddata.dart';
import 'package:covid19/pages/ResultPage.dart';
import 'package:flutter/material.dart';

class ShowList extends StatefulWidget {
  final List<Country> value;
  final Map<String, dynamic> info;
  final List<String> countries;
  final Map<String, Country> map;

  ShowList({@required this.value, this.info, this.countries, this.map});

  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TopBar(widget: widget),
        CountryList(widget: widget),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ShowList widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              color: Colors.white,
              height: 1,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Total Cases",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              widget.info['cases'].toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Total Deaths",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.info['deaths'].toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Recovered",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.info['recovered'].toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}

class CountryList extends StatelessWidget {
  const CountryList({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final ShowList widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.value.length,
        itemBuilder: ((context, index) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 5.0,
              ),
              RaisedButton(
                padding: EdgeInsets.all(0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    CountryFlag(widget: widget, index: index),
                    SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      height: 50.0,
                      width: 1.0,
                      color: Colors.grey,
                    ),
                    CountryInfo(widget: widget, index: index),
                  ],
                ),
                onPressed: () {
                  return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        map: widget.map,
                        query: widget.value[index].name,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

class CountryFlag extends StatelessWidget {
  const CountryFlag({
    Key key,
    @required this.widget,
    @required this.index,
  }) : super(key: key);

  final ShowList widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: widget.value[index].flag,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.transparent,
          backgroundImage: imageProvider,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}

class CountryInfo extends StatelessWidget {
  const CountryInfo({
    Key key,
    @required this.widget,
    @required this.index,
  }) : super(key: key);

  final ShowList widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Container(
            child: Text(
              widget.value[index].name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.74,
              color: Colors.grey,
              height: 1,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Total cases",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.value[index].cases.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Deaths",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.value[index].deaths.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "Recovered",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.value[index].recovered.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
