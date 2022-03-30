import 'package:flutter/material.dart';
import 'package:restaurant_api_app/data/model/menus.dart';

class FoodCard extends StatelessWidget {
  final Menus menus;

  FoodCard({Key? key, required this.menus}) : super(key: key);

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
                          'assets/foodrest.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        menus.foods[index].name,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const Text('Rp. 25.000')
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemCount: menus.foods.length),
        ),
      ],
    );
  }
}
