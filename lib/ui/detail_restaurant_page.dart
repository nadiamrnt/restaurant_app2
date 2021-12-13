import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/top_icon.dart';

import '../widget/detail_content.dart';
import '../widget/gradient_animation.dart';

class DetailRestaurantPage extends StatefulWidget {
  static const routeName = '/detail_restaurant';
  final Restaurant restaurant;
  const DetailRestaurantPage({required this.restaurant});

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) {
        RestaurantProvider();
        return RestaurantProvider().detailRestaurant(widget.restaurant.id);
      },
      child: Scaffold(
        body: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: LottieBuilder(
                  lottie: NetworkLottie(
                      'https://assets2.lottiefiles.com/datafiles/bEYvzB8QfV3EM9a/data.json'),
                ),
              );
            } else if (state.state == ResultState.NoData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == ResultState.HasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          state.resultDetail.restaurant.getMediumPicture(),
                          height: MediaQuery.of(context).size.height * 1 / 2,
                          fit: BoxFit.cover,
                        ),
                        GradientAnimation(),
                        TopIcon(restaurant: widget.restaurant)
                      ],
                    ),
                    DetailContent(
                      restaurant: state.resultDetail.restaurant,
                      id: widget.restaurant.id,
                    )
                  ],
                ),
              );
            } else if (state.state == ResultState.Error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }
}
