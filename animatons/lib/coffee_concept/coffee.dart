import 'dart:math';

final _random = Random();

double _doubleInRange(Random source, num start, num end) =>
    source.nextDouble() * (end - start) + start;

final coffees = List.generate(
  _names.length,
  (index) => Coffee(
    name: _names[index],
    image: 'assets/coffee_concept/${index + 1}.png',
    price: _doubleInRange(_random, 3, 7),
  ),
);

class Coffee {
  final String name;
  final String image;
  final double price;
  Coffee({
    required this.name,
    required this.image,
    required this.price,
  });
}

final _names = [
  'Caramel Macchiato',
  'Caramel Cold Drink',
  'Iced Coffe Mocha',
  'Caramelized Pecan Latte',
  'Toffee Nut Latte',
  'Capuchino',
  'Toffee Nut Iced Latte',
  'Americano',
  'Vietnamese-Style Iced Coffee',
  'Black Tea Latte',
  'Classic Irish Coffee',
  'Toffee Nut Crunch Latte',
];
