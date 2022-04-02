import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/common/style/style.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/provider/search_provider.dart';
import 'package:restaurant_api_app/widget/card_list.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search_restaurant';
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search',style: Theme.of(context).textTheme.headline5,),
          backgroundColor: secondaryColor,
        ),
        body: MainSearch(),
      ),
    );
  }
}

class MainSearch extends StatelessWidget {
  const MainSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Find Your Restaurant',
                  ),
                  onFieldSubmitted: (value) {
                    searchProvider.addSearchQuery(value);
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Consumer<SearchProvider>(
            builder: (context, result, _) {
              if (result.state == ResultState.noQuery) {
                return Center(
                  child: Text('Lets Search Your Restaurant',style: Theme.of(context).textTheme.subtitle1,),
                );
              } else if (result.state == ResultState.loading) {
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Please Wait',style: Theme.of(context).textTheme.subtitle1,)
                    ],
                  ),
                );
              } else if (result.state == ResultState.noData) {
                return Center(
                  child: Column(
                    children: [
                      Icon(Icons.not_interested_outlined,size: 24,),
                      Text('No Result',style: Theme.of(context).textTheme.subtitle1,)
                    ],
                  ),
                );
              } else if (result.state == ResultState.error) {
                return Center(
                  child: Column(
                    children: [
                      Icon(Icons.error_outline_outlined,),
                      Text('Failed to load Search Restaurant',style: Theme.of(context).textTheme.subtitle1,)
                    ],
                  ),
                );
              } else if (result.state == ResultState.hasData) {
                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: result.result.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant = result.result.restaurants[index];
                      return CardList(restaurant: restaurant);
                    },
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.blue,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text('NULL',style: Theme.of(context).textTheme.subtitle1),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
