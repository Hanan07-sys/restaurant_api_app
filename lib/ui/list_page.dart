import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/common/style/style.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/data/model/restaurant_list.dart';
import 'package:restaurant_api_app/provider/list_provider.dart';
import 'package:restaurant_api_app/ui/favorite_page.dart';
import 'package:restaurant_api_app/ui/search_page.dart';
import 'package:restaurant_api_app/ui/setting_page.dart';
import 'package:restaurant_api_app/util/result_state.dart';
import 'package:restaurant_api_app/widget/card_list.dart';

class ListRestaurant extends StatefulWidget {
  static const routeName = '/list_restaurant';

  @override
  State<ListRestaurant> createState() => _ListRestaurantState();
}

class _ListRestaurantState extends State<ListRestaurant> {
  int currentIndex = 0;
  Future<RestaurantList>? _restaurant;

  @override
  void initState() {
    super.initState();
    _restaurant = ApiService().listRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      _buildList(context),
      FavoritePage(),
      SettingPage(),
    ];
    return ChangeNotifierProvider(
      create: (context) => ListProvider(apiService: ApiService()),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 240,
                pinned: true,
                backgroundColor: secondaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Recommendation For You!',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SearchPage.routeName);
                      },
                      icon: Icon(
                        Icons.search,
                        color: primaryColor,
                        size: 28,
                      ),
                    ),
                  ],
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/food.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ];
          },
          body: widgets[currentIndex],
        ),
        bottomNavigationBar: ConvexAppBar(
            backgroundColor: Colors.black54,
            color: primaryColor,
            items: [
              TabItem(icon: Icon(Icons.home), title: 'Home'),
              TabItem(icon: Icon(Icons.favorite_outlined), title: 'Favorite'),
              TabItem(icon: Icon(Icons.settings), title: 'Settings'),
            ],
            initialActiveIndex: 0,
            onTap: (int i) {
              setState(() {
                currentIndex = i;
              });
            }),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<ListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardList(restaurant: restaurant);
            },
            separatorBuilder: (context, index) => const Divider(
              color: Colors.blue,
            ),
          );
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('NULL'));
        }
      },
    );
  }
}
