import 'package:flutter/material.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/data/model/restaurant_detail.dart';
import 'package:restaurant_api_app/util/result_state.dart';

class DetailProvider extends ChangeNotifier {
  late final ApiService apiService;
  String id;

  DetailProvider({required this.apiService, required this.id}) {
    _fetchAllDetail();
  }

  late DetailRestaurant _detailRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  DetailRestaurant get result => _detailRestaurant;
  ResultState get state => _state;

  Future<dynamic> _fetchAllDetail() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(id);
      if (restaurant.restaurant.name == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Failed To Load Data, Please Check Your Connection';
    }
  }
}
