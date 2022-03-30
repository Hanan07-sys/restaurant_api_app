import 'package:flutter/material.dart';
import 'package:restaurant_api_app/style/style.dart';
import 'package:restaurant_api_app/ui/detail_page.dart';
import 'package:restaurant_api_app/ui/list_page.dart';
import 'package:restaurant_api_app/ui/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: primaryColor,
          secondary: secondaryColor
        ),
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
        SearchPage.routeName:(context)=>SearchPage()
      },
    );
  }
}
