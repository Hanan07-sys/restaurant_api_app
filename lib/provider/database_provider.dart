
import 'package:flutter/material.dart';
import 'package:restaurant_api_app/data/database/database_helper.dart';
import 'package:restaurant_api_app/data/model/restaurant.dart';
import 'package:restaurant_api_app/util/result_state.dart';

class DatabaseFavoriteProvider extends ChangeNotifier{
  final DatabaseHelper databaseHelper;

  DatabaseFavoriteProvider({required this.databaseHelper}){
    _getFavorite();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message ='';
  String get message => _message;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  void _getFavorite() async{
    _favorite = await databaseHelper.getFavorite();
    if(_favorite.isNotEmpty){
      _state = ResultState.hasData;
    }
    else{
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }
  void addFavorite(Restaurant restaurant) async{
    try{
      await databaseHelper.insertFavorite(restaurant);
    }catch (e){
      _state = ResultState.error;
      _message = 'Error ->$e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async{
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void deleteFavorite(String id) async{
    try{
      await databaseHelper.deleteFavorite(id);
      _getFavorite();
    }catch(e){
      _state = ResultState.error;
      _message = 'Error -> $e';
      notifyListeners();
    }
  }
}