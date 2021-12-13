import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/detail_restaurant.dart';

import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DetailContent extends StatefulWidget {
  const DetailContent({
    required this.restaurant,
    required this.id,
  });

  final String id;
  final DetailRestaurant restaurant;

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider().detailRestaurant(widget.id),
        child: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 1 / 3),
                child: Center(
                  child: LottieBuilder(
                    lottie: NetworkLottie(
                        'https://assets2.lottiefiles.com/datafiles/bEYvzB8QfV3EM9a/data.json'),
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
            } else if (state.state == ResultState.HasData) {
              return Container(
                height: MediaQuery.of(context).size.height * 1.3,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 2 / 5),
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.restaurant.name,
                                style: TextStyle(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    widget.restaurant.city,
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              ),
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
                                size: 35.0,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                widget.restaurant.rating.toString(),
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.restaurant.description,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Foods',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: foodMenu(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Drink',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: drinkMenu(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Customer Review',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: customerReviews(),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(' '),
              );
            }
          },
        ));
  }

  Container foodMenu() {
    return Container(
      child: ListView.builder(
        itemCount: widget.restaurant.menus.foods.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              Flexible(
                flex: 6,
                child: Image.asset(
                  'assets/dummy_food.jpg',
                  height: MediaQuery.of(context).size.height * 1 / 6,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(widget.restaurant.menus.foods
                      .map((e) => e.name)
                      .toList()[index]
                      .toString()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container drinkMenu() {
    return Container(
        child: ListView.builder(
      itemCount: widget.restaurant.menus.drinks.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Flexible(
              flex: 6,
              child: Image.asset(
                'assets/dummy_drink.jpg',
                height: MediaQuery.of(context).size.height * 1 / 6,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 1,
              child: Text(widget.restaurant.menus.drinks
                  .map((e) => e.name)
                  .toList()[index]
                  .toString()),
            )
          ],
        ),
      ),
    ));
  }

  Container customerReviews() {
    return Container(
      child: ListView.builder(
        itemCount: widget.restaurant.customerReviews.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.restaurant.customerReviews
                    .map((e) => e.name)
                    .toList()[index]
                    .toString(),
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(widget.restaurant.customerReviews
                  .map((e) => e.review)
                  .toList()[index]
                  .toString()),
            ],
          ),
        ),
      ),
    );
  }
}
