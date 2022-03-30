
import 'package:flutter/material.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/data/model/restaurant_list.dart';

enum ResultState {loading, noData, hasData, error}


class ListProvider extends ChangeNotifier{
  final ApiService apiService;

  ListProvider({required this.apiService}) {
    _fetchAllList();
  }

  late RestaurantList _listRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantList get result => _listRestaurant;

  ResultState get state => _state;

  Future <dynamic> _fetchAllList() async{
    try{
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurant();
      if(restaurant.restaurants.isEmpty){
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      }
      else{
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurant = restaurant;
      }
    }catch (e){
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Failed To Load Data, Please Check Your Connection';
    }
  }

}