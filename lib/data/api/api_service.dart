import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_api_app/data/model/restaurant_detail.dart';
import 'package:restaurant_api_app/data/model/restaurant_list.dart';
import 'package:restaurant_api_app/data/model/restaurant_search.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> listRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Restaurant List');
    }
  }

  Future<DetailRestaurant> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail List Restaurant');
    }
  }
  Future<SearchRestaurant> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=$query"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Search Restaurant');
    }
  }


}
