import 'package:flutter/cupertino.dart';

class Ingredient {
  final String image;
  final String imageUnit;
  final List<Offset> positions;

  const Ingredient({
    required this.image,
    required this.imageUnit,
    required this.positions,
  });

  bool compare(Ingredient ingredient) => ingredient.image == image;
}

final ingredients = const <Ingredient>[
  Ingredient(
    image: 'assets/pizza_order/chili.png',
    imageUnit: 'assets/pizza_order/chili_unit.png',
    positions: <Offset>[
      Offset(0.2, 0.2),
      Offset(0.6, 0.2),
      Offset(0.4, 0.25),
      Offset(0.5, 0.3),
      Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: 'assets/pizza_order/mushroom.png',
    imageUnit: 'assets/pizza_order/mushroom_unit.png',
    positions: [
      Offset(0.2, 0.35),
      Offset(0.65, 0.35),
      Offset(0.3, 0.23),
      Offset(0.5, 0.2),
      Offset(0.3, 0.5),
    ],
  ),
  Ingredient(
    image: 'assets/pizza_order/olive.png',
    imageUnit: 'assets/pizza_order/olive_unit.png',
    positions: [
      Offset(0.25, 0.5),
      Offset(0.65, 0.6),
      Offset(0.2, 0.3),
      Offset(0.4, 0.2),
      Offset(0.2, 0.6),
    ],
  ),
  Ingredient(
    image: 'assets/pizza_order/onion.png',
    imageUnit: 'assets/pizza_order/onion.png',
    positions: [
      Offset(0.2, 0.65),
      Offset(0.65, 0.3),
      Offset(0.25, 0.25),
      Offset(0.45, 0.35),
      Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: 'assets/pizza_order/pea.png',
    imageUnit: 'assets/pizza_order/pea_unit.png',
    positions: [
      Offset(0.2, 0.35),
      Offset(0.65, 0.35),
      Offset(0.3, 0.23),
      Offset(0.5, 0.2),
      Offset(0.3, 0.5),
    ],
  ),
  Ingredient(
    image: 'assets/pizza_order/pickle.png',
    imageUnit: 'assets/pizza_order/pickle_unit.png',
    positions: [
      Offset(0.2, 0.65),
      Offset(0.65, 0.3),
      Offset(0.25, 0.25),
      Offset(0.45, 0.35),
      Offset(0.4, 0.65),
    ],
  ),
  Ingredient(
    image: 'assets/pizza_order/potato.png',
    imageUnit: 'assets/pizza_order/potato_unit.png',
    positions: [
      Offset(0.2, 0.2),
      Offset(0.6, 0.2),
      Offset(0.4, 0.25),
      Offset(0.5, 0.3),
      Offset(0.4, 0.65),
    ],
  ),
];
