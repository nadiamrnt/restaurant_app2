import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState? _state;
  ResultState get state => _state!;

  String _message = '';
  String get message => _message;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get favorites => _restaurants;

  void _getFavorites() async {
    _state = ResultState.Loading;
    notifyListeners();
    _restaurants = await databaseHelper.getFavorites();
    if (_restaurants.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.addFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
