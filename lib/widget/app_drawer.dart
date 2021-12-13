import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/main_screen.dart';
import 'package:restaurant_app/ui/favorite_screen.dart';
import 'package:restaurant_app/ui/setting_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("MENU",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, MainScreen.routeName);
                },
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 25,
                ),
                title: Text('Home', style: TextStyle(fontSize: 18)),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, FavoriteScreen.routeName);
                },
                leading: Icon(
                  Icons.favorite,
                  color: Colors.black,
                  size: 25,
                ),
                title: Text('Favorite', style: TextStyle(fontSize: 18)),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, SettingScreen.routeName);
                },
                leading: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 25,
                ),
                title: Text('Settings', style: TextStyle(fontSize: 18)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
