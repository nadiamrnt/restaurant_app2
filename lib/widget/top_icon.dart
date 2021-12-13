import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class TopIcon extends StatefulWidget {
  final Restaurant restaurant;
  TopIcon({required this.restaurant});

  @override
  _TopIconState createState() => _TopIconState();
}

class _TopIconState extends State<TopIcon> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<RestaurantProvider, DatabaseProvider>(
      builder: (context, state, db, child) {
        return FutureBuilder<bool>(
          future: db.isFavorited(widget.restaurant.id),
          builder: (context, snapshot) {
            var _isFavorited = snapshot.data ?? false;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: _isFavorited
                          ? IconButton(
                              icon: Icon(Icons.favorite),
                              color: Colors.red,
                              onPressed: () {
                                db.removeFavorite(widget.restaurant.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Deleted from favorite list')));
                              },
                            )
                          : IconButton(
                              icon: Icon(Icons.favorite_border),
                              color: Colors.red,
                              onPressed: () {
                                db.addFavorite(widget.restaurant);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Added to favorite list')));
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
