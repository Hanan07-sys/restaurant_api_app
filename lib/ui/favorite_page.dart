import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/provider/database_provider.dart';
import 'package:restaurant_api_app/util/result_state.dart';
import 'package:restaurant_api_app/widget/card_list.dart';

class FavoritePage extends StatelessWidget {
  static const routeName = '/favorite_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainFavorite(),
    );
  }
}

class MainFavorite extends StatelessWidget {
  const MainFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: Consumer<DatabaseFavoriteProvider>(builder: (context, result, child) {
              if (result.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (result.state == ResultState.hasData) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: result.favorite.length,
                  itemBuilder: (context, index) {
                    var restaurant = result.favorite[index];
                    return CardList(restaurant: restaurant);
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.blue,
                  ),
                );
              } else if (result.state == ResultState.noData) {
                return Center(child: Text(result.message));
              } else if (result.state == ResultState.error) {
                return Center(child: Text(result.message));
              } else {
                return const Center(child: Text('NULL'));
              }
            }),
          ),
        ],
      ),
    );
  }
}
