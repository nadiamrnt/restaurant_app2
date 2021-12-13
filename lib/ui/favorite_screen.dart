import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/app_drawer.dart';
import 'package:restaurant_app/widget/favorite_card.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite_screen';
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Favorite",
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
      body: Consumer<DatabaseProvider>(
        builder: (context, db, child) {
          if (db.state == ResultState.HasData) {
            return ListView.builder(
              itemCount: db.favorites.length,
              itemBuilder: (context, index) {
                return FavoriteCard(restaurant: db.favorites[index]);
              },
            );
          } else if (db.state == ResultState.Loading) {
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 1 / 3),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (db.state == ResultState.NoData) {
            return Center(
              child: Text(db.message),
            );
          } else if (db.state == ResultState.Error) {
            return Center(
              child: Text(db.message),
            );
          } else {
            return Center(
              child: Text(db.message),
            );
          }
        },
      ),
    );
  }
}
