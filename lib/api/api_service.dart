import 'dart:convert';

import 'package:restaurant_app/data/detail_restaurant.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:http/http.dart' as http;

import 'package:restaurant_app/data/search_restaurant.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String _listRestaurant = 'list';
  static final String _detailRestaurant = 'detail/';
  static final String _searchRestaurant = 'search?q=';

  Future<ListRestaurant> listRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _listRestaurant));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant');
    }
  }

  Future<SearchRestaurant> searchRestaurant(String query) async {
    final response =
        await http.get(Uri.parse(_baseUrl + _searchRestaurant + query));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Search Failed');
    }
  }

  Future<DtlRestaurant> detailRestaurant(final String id) async {
    final response =
        await http.get(Uri.parse(_baseUrl + _detailRestaurant + id));
    if (response.statusCode == 200) {
      return DtlRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }
}
