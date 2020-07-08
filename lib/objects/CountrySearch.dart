import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19/objects/Worlddata.dart';
import 'package:covid19/pages/ResultPage.dart';
import 'package:flutter/material.dart';

class CountrySearch extends SearchDelegate<Country> {
  List<String> countries;
  Map<String, Country> map;

  List<String> suggestion;

  CountrySearch({this.countries, this.map});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            showSuggestions(context);
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Widget searchResult = suggestion.isEmpty || query.isEmpty
        ? Container(
            child: Center(
              child: Text('No Suggestion'),
            ),
          )
        : ResultPage(map: map, query: query);
    return searchResult;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    suggestion =
        countries.where((String p) => p.toLowerCase().contains(query)).toList();

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: suggestionList(index, context),
              );
            },
            itemCount: suggestion.length,
          ),
        ),
      ],
    );
  }

  ListTile suggestionList(int index, BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: map[suggestion[index]].flag,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: imageProvider,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      title: Text(
        suggestion[index],
        style: TextStyle(fontSize: 20.0),
      ),
      onTap: () {
        query = suggestion[index];
        showResults(context);
      },
    );
  }
}
