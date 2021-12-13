import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/widget/app_drawer.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/setting_screen';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferencesProvider, SchedulingProvider>(
      builder: (context, provider, scheduled, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Settings",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Coming Soon!!!')));
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
          body: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Set Daily Remainder",
                  style: TextStyle(fontSize: 18.0),
                ),
                Switch(
                    value: provider.isRemainderActive,
                    onChanged: (value) async {
                      scheduled.scheduledRemainder(value);
                      provider.enableDailyRemainder(value);

                      value
                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Daily Remainder Activate')))
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Scheduling Canceled')));
                    },),
              ],
            ),
          ),
        );
      },
    );
  }
}
