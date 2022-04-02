import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/common/style/style.dart';
import 'package:restaurant_api_app/data/database/database_helper.dart';
import 'package:restaurant_api_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_api_app/provider/database_provider.dart';
import 'package:restaurant_api_app/provider/preferences_provider.dart';
import 'package:restaurant_api_app/provider/schedulling_provider.dart';
import 'package:restaurant_api_app/ui/detail_page.dart';
import 'package:restaurant_api_app/ui/favorite_page.dart';
import 'package:restaurant_api_app/ui/list_page.dart';
import 'package:restaurant_api_app/ui/search_page.dart';
import 'package:restaurant_api_app/ui/setting_page.dart';
import 'package:restaurant_api_app/util/background_service.dart';
import 'package:restaurant_api_app/util/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  await AndroidAlarmManager.initialize();

  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(MyApp());

}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DatabaseFavoriteProvider>(
          create: (_) =>
              DatabaseFavoriteProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance()
            ),
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) =>
              SchedulingProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(primary: primaryColor, secondary: secondaryColor),
          textTheme: myTextTheme,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: ListRestaurant.routeName,
        routes: {
          ListRestaurant.routeName: (context) => ListRestaurant(),
          DetailPageRestaurant.routeName: (context) => DetailPageRestaurant(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
          SearchPage.routeName: (context) => SearchPage(),
          SettingPage.routeName: (context) => SettingPage(),
          FavoritePage.routeName: (context) => FavoritePage()
        },
      ),
    );
  }
}
