import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

import 'package:restaurant_app/ui/detail_restaurant_page.dart';
import 'package:restaurant_app/ui/main_screen.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/splash_screen.dart';
import 'package:restaurant_app/ui/favorite_screen.dart';
import 'package:restaurant_app/ui/setting_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider().listRestaurant(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          MainScreen.routeName: (context) => MainScreen(),
          DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          FavoriteScreen.routeName: (context) => FavoriteScreen(),
          SettingScreen.routeName: (context) => SettingScreen()
        },
      ),
    );
  }
}
