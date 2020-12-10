import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/models/place.dart';


class AddressSearch extends SearchDelegate<Place> {


  @override
  List<Widget> buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

@override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : APIService.route(ENDPOINTS.Locations, "/location",urlArgs: query),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title:
                        Text((snapshot.data[index] as Place).description),
                    onTap: () {
                      close(context, snapshot.data[index] as Place);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}