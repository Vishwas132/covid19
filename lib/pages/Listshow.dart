import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19/objects/Dataloader.dart';
import 'package:covid19/objects/Worlddata.dart';
import 'package:covid19/pages/ResultPage.dart';
import 'package:flutter/material.dart';

class Listshow extends StatefulWidget {
  final List<Country> value;
  final Map<String, dynamic> info;
  final List<String> countries;
  final Map<String, Country> map;

  Listshow({@required this.value, this.info, this.countries, this.map});

  @override
  _ListshowState createState() => _ListshowState();
}

class _ListshowState extends State<Listshow> {
  Router r = Router();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 160.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
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
                      fontSize: 25,
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Center(
                          child: Text(
                        "Total Deaths",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )),
                      Center(
                          child: Text(
                        widget.info['deaths'].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                          child: Text(
                        "Recovered",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )),
                      Center(
                          child: Text(
                        widget.info['recovered'].toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.value.length,
              itemBuilder: ((context, index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: FlatButton(
                        padding: EdgeInsets.all(0.0),
                        child: Card(
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: widget.value[index].flag,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius: 27.0,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: imageProvider,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        widget.value[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.74,
                                      color: Colors.grey[300],
                                      height: 1,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Expanded(
                                            child: Center(
                                                child: Text(
                                          "Total cases",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                        Expanded(
                                            child: Center(
                                                child: Text(
                                          "Deaths",
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                        Expanded(
                                          child: Center(
                                              child: Text(
                                            "Recovered",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Center(
                                                child: Text(
                                          widget.value[index].cases.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                        Expanded(
                                            child: Center(
                                                child: Text(
                                          widget.value[index].deaths.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                        Expanded(
                                          child: Center(
                                              child: Text(
                                            widget.value[index].recovered
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                        onPressed: () {
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultPage(
                                countries: widget.countries,
                                map: widget.map,
                                query: widget.value[index].name,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                );
              })),
        )
      ],
    );
  }
}
