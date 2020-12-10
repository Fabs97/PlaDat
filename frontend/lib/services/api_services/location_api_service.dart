import 'dart:convert';

import 'package:frontend/models/place.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationsAPIService  {
  static Future<dynamic> route(String subRoute,
      {dynamic body, dynamic urlArgs}) {
    switch (subRoute) {
      case "/location":
        return fetchPlaces(subRoute, urlArgs);
      default:
        throw LocationAPIException();
    }
  }

 

  static Future<List<Place>> fetchPlaces(String subRoute,String input) async {
  final response =
      await http.get('https://cors-anywhere.herokuapp.com/https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=en&key=${DotEnv().env['GPLACES_APIKEY']}', headers: {"Accept":"Application/json"});
  
  if (response.statusCode == 200){
  var preObjsJson = jsonDecode(response.body)['predictions'] as List;
  List<Place> tagObjs = preObjsJson.map((tagJson) => Place.fromJson(tagJson)).toList();
  return tagObjs;   
  }
  
}
}

class LocationAPIException extends APIException {}
