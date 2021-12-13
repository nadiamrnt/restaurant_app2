import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import 'package:restaurant_app/widget/app_drawer.dart';

import 'package:restaurant_app/widget/staggered_grid_restaurant.dart';
import 'package:restaurant_app/widget/staggered_search_result.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _searchController = TextEditingController();
  String query = '';
  Widget staggered = StaggeredGridRestaurant();

  final _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      DetailRestaurantPage.routeName,
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider().listRestaurant(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Home",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Coming Soon!!!')));
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 30,
                ))
          ],
          iconTheme: IconThemeData(color: Colors.black),
        ),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: _searchController.text.isEmpty
                              ? Colors.grey
                              : Colors.red,
                        ),
                        onPressed: _searchController.text.isEmpty
                            ? null
                            : () {
                                setState(() {
                                  staggered = StaggeredGridRestaurant();
                                  _searchController.clear();
                                });
                              },
                      )),
                  onSubmitted: (String value) {
                    setState(() {
                      if (_searchController.text.isEmpty) {
                        staggered = StaggeredGridRestaurant();
                      } else {
                        staggered = StaggeredSearchResult(query: value);
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: staggered,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
