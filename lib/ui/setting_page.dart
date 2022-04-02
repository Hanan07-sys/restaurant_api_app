import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/provider/preferences_provider.dart';
import 'package:restaurant_api_app/provider/schedulling_provider.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting_page';

  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainSetting(),
    );
  }
}

class MainSetting extends StatelessWidget {
  const MainSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return ListTile(
            title: Text('Daily Restaurant',style: Theme.of(context).textTheme.headline6),
            subtitle: Text('Notification',style: Theme.of(context).textTheme.subtitle1),
            trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
              return Switch.adaptive(
                  value: provider.isDailyNotificationActive,
                  onChanged: (value) async {
                    scheduled.scheduledNotification(value);
                    provider.enableDailyNotification(value);
                  });
            }));
      }),
    );
  }
}
