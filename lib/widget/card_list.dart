import 'package:flutter/material.dart';
import 'package:restaurant_api_app/data/model/restaurant.dart';
import 'package:restaurant_api_app/ui/detail_page.dart';

class CardList extends StatelessWidget {
  final Restaurant restaurant;

  const CardList({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: Image.network(
          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
          width: 100,
          height: 90,
          fit: BoxFit.cover,
        ),
        title: Text(restaurant.name,style: Theme.of(context).textTheme.headline6,),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 3,
            ),
            Text(restaurant.city,style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(restaurant.rating.toString(),style:  Theme.of(context).textTheme.subtitle2,),
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                )
              ],
            )
          ],
        ),
        trailing: const Icon(Icons.navigate_next),
        onTap: () {
          Navigator.pushNamed(context, DetailPageRestaurant.routeName,arguments: restaurant.id);
        },
      ),
    );
  }
}
