import 'package:flutter/material.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/ui/detail_restaurant_page.dart';

class FavoriteCard extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurantPage.routeName,
            arguments: restaurant);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
        child: Row(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Text('No Internet Connection'),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      restaurant.city,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      'Rating :',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      restaurant.rating.toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.yellow[800],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
