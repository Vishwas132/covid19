import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19/objects/Worlddata.dart';
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
        : buildSuggestions(context);
    return searchResult;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestion = countries
        .where((String str) => compareTextToCountry(query: query, str: str))
        .toList();

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey[300],
                  ),
                  shape: BoxShape.rectangle,
                ),
                child: suggestionList(index, context),
              );
            },
            itemCount: suggestion.length,
          ),
        ),
      ],
    );
  }

  // Compare typed text to country name to show suggestion
  bool compareTextToCountry({String query, String str}) =>
      str.toLowerCase().contains(query);

  // Build list of suggestion
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
