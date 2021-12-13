import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/search_restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';

import '../ui/detail_restaurant_page.dart';

class StaggeredSearchResult extends StatelessWidget {
  final String query;
  const StaggeredSearchResult({required this.query});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider().searchRestaurant(query),
      child: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(
              child: LottieBuilder(
                lottie: NetworkLottie(
                    'https://assets2.lottiefiles.com/datafiles/bEYvzB8QfV3EM9a/data.json'),
              ),
            );
          } else if (state.state == ResultState.HasData) {
            return Container(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 6 / 8,
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  itemCount: state.resultSearch.founded,
                  itemBuilder: (context, index) {
                    return _buildRestaurantCard(
                        context, state.resultSearch.searchRestaurants[index]);
                  },
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
              ),
            );
          } else if (state.state == ResultState.NoData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.Error) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
              child: Text(' '),
            );
          }
        },
      ),
    );
  }

  Widget _buildRestaurantCard(
      BuildContext context, SearchRestaurantResult restaurant) {
    double randomNumber = Random().nextInt(120) + 130;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurantPage.routeName,
            arguments: restaurant);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          child: Stack(
            children: [
              Image.network(
                restaurant.getMediumPicture(),
                height: randomNumber,
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(0.9),
                    ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.yellow[800],
                                size: 16.0,
                              ),
                              Text(
                                restaurant.city,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[800],
                          ),
                          Text(
                            restaurant.rating.toString(),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
