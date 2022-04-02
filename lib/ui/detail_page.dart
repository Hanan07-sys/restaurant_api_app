import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api_app/common/style/style.dart';
import 'package:restaurant_api_app/data/api/api_service.dart';
import 'package:restaurant_api_app/data/model/restaurant.dart';
import 'package:restaurant_api_app/provider/database_provider.dart';
import 'package:restaurant_api_app/provider/detail_provider.dart';
import 'package:restaurant_api_app/util/result_state.dart';
import 'package:restaurant_api_app/widget/costume_scaffold.dart';
import 'package:restaurant_api_app/widget/drinkcard.dart';
import 'package:restaurant_api_app/widget/foodcard.dart';

class DetailPageRestaurant extends StatelessWidget {
  static const routeName = '/detail_restaurant';
  final String id;

  DetailPageRestaurant({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(apiService: ApiService(), id: id),
      child:  MainDetail(),
    );
  }
}

class MainDetail extends StatelessWidget {
  const MainDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return Content(
              state: state,
            );
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.error) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('NULL'));
          }
        },
      ),
    );
  }
}

class Content extends StatelessWidget {
  DetailProvider state;

  Content({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  'https://restaurant-api.dicoding.dev/images/large/${state.result.restaurant.pictureId}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        buildName(context),
                        const SizedBox(
                          width: 5,
                        ),
                        buildRating(),
                        const Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                        ),
                        Consumer<DatabaseFavoriteProvider>(
                         builder: (context, result, child){
                           return FutureBuilder<bool>(
                             future: result.isFavorite(state.result.restaurant.id),
                             builder: (context,snapshot){
                               var isFavorite = snapshot.data ??false;
                               var data = Restaurant(id: state.result.restaurant.id,
                                   name: state.result.restaurant.name,
                                   description: state.result.restaurant.description,
                                   pictureId: state.result.restaurant.pictureId,
                                   city: state.result.restaurant.city,
                                   rating: state.result.restaurant.rating);
                               return isFavorite
                                   ? InkWell(
                                 onTap: () => result.deleteFavorite(
                                     state.result.restaurant.id),
                                 child: Icon(
                                   Icons.favorite,
                                   color: Colors.redAccent,
                                 ),
                               )
                                   : InkWell(
                                 onTap: () => result.addFavorite(data),
                                 child: Icon(
                                   Icons.favorite_border,
                                   color: Colors.grey,
                                 ),
                               );
                             },
                           );
                         },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildCity(context),
                    buildDescription(context),
                  ],
                ),
              ),
              cardFood(context),
              const SizedBox(
                height: 10,
              ),
              FoodCard(menus: state.result.restaurant.menus),
              cardDrinks(context),
              const SizedBox(
                height: 10,
              ),
              DrinkCard(
                menus: state.result.restaurant.menus,
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildCity(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_sharp,
          color: Colors.red.withOpacity(0.8),
        ),
        Text(state.result.restaurant
                .city // style: Theme.of(context).textTheme.headline6,
            ),
      ],
    );
  }

  Text buildRating() => Text(
        state.result.restaurant.rating.toString(),
      );

  Text buildName(BuildContext context) {
    return Text(
      state.result.restaurant.name,style: Theme.of(context).textTheme.headline6
      // style: Theme.of(context).textTheme.headline6,
    );
  }

  Column buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children:  [
            Text(
              'Description',
              style: Theme.of(context).textTheme.bodyText1
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          state.result.restaurant.description,
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Card cardFood(BuildContext context) {
    return Card(
      color: foodColor,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text(
              'FOOD',
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
    );
  }

  Card cardDrinks(BuildContext context) {
    return Card(
      color: drinkColor,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text(
              'Drinks',
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
    );
  }
}
