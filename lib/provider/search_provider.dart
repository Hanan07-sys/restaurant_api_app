import 'package:flutter/material.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/data/model/restaurant_search.dart';

enum ResultState { loading, noData, hasData, error, noQuery }

class SearchProvider extends ChangeNotifier {
  late final ApiService apiService;

  SearchProvider({required this.apiService}) {
    _fetchAllSearch();
  }

  late SearchRestaurant _searchRestaurant;
  late ResultState _state;
  String _message = '';
  String query = "";

  String get message => _message;
  SearchRestaurant get result => _searchRestaurant;
  ResultState get state => _state;

  Future<dynamic> _fetchAllSearch() async {
    if (query != "") {
      try {
        _state = ResultState.loading;
        notifyListeners();
        final restaurant = await apiService.searchRestaurant(query);
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _searchRestaurant = restaurant;
        }
      } catch (e) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Failed To Load Data, Please Check Your Connection';
      }
    } else {
      _state = ResultState.noQuery;
      notifyListeners();
      return _message = 'Query Not Found';
    }
  }

  void addSearchQuery(String query) {
    this.query = query;
    _fetchAllSearch();
    notifyListeners();
  }
}
