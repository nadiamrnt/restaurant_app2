import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/data/detail_restaurant.dart';
import 'package:restaurant_app/data/restaurant.dart';

import 'package:restaurant_app/data/search_restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  RestaurantProvider listRestaurant() {
    _fetchListRestaurant();
    return this;
  }

  RestaurantProvider detailRestaurant(String id) {
    _fetchDetailRestaurant(id);
    return this;
  }

  RestaurantProvider searchRestaurant(String query) {
    _fetchSearchRestaurant(query);
    return this;
  }

  late ListRestaurant _listRestaurant;
  late DtlRestaurant _detailRestaurant;
  late SearchRestaurant _searchRestaurant;
  late ResultState _state;
  String _message = '-';

  String get message => _message;

  ListRestaurant get resultList => _listRestaurant;

  DtlRestaurant get resultDetail => _detailRestaurant;

  SearchRestaurant get resultSearch => _searchRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchListRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'No Internet Connection';
    }
  }

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(id);
      if (!restaurant.error) {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailRestaurant = restaurant;
      } else {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'No Internet Connection';
    }
  }

  Future<dynamic> _fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.searchRestaurant(query);
      if (restaurant.searchRestaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Search Not Found';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'No Internet Connection';
    }
  }
}
