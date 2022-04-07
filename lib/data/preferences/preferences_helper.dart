
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper{
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const restaurantDaily = 'RESTAURANT_DAILY';

  Future<bool> get isDailyNotificationActive async{
    final prefs = await sharedPreferences;
    return prefs.getBool(restaurantDaily) ?? false;
  }

  void setDailyNotification(bool value) async{
    final prefs = await sharedPreferences;
    prefs.setBool(restaurantDaily, value);
  }
}