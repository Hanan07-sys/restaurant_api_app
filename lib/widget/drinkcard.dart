import 'package:flutter/material.dart';
import 'package:restaurant_api_app/data/model/menus.dart';

class DrinkCard extends StatelessWidget {
  final Menus menus;

  DrinkCard({Key? key, required this.menus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 150,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 150,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/drinksrest.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(menus.drinks[index].name,
                          style: Theme.of(context).textTheme.bodyText2),
                      const Text('Rp. 20.000')
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemCount: menus.drinks.length),
        ),
      ],
    );
  }
}
