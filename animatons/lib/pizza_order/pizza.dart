class Pizza {
  final int price;
  final int stars;
  final String image;
  final String name;

  Pizza({
    required this.price,
    required this.stars,
    required this.image,
    required this.name,
  });
}

final pizzas = <Pizza>[
  Pizza(
    price: 15,
    stars: 5,
    image: 'assets/pizza_order/pizza-1.png',
    name: 'New Orleans Pizza',
  ),
  Pizza(
    price: 14,
    stars: 1,
    image: 'assets/pizza_order/pizza-2.png',
    name: 'Huston Pizza',
  ),
  Pizza(
    price: 13,
    stars: 5,
    image: 'assets/pizza_order/pizza-3.png',
    name: 'Even Yehuda Pizza',
  ),
  Pizza(
    price: 20,
    stars: 4,
    image: 'assets/pizza_order/pizza-4.png',
    name: 'New York Pizza',
  ),
  Pizza(
    price: 10,
    stars: 3,
    image: 'assets/pizza_order/pizza-5.png',
    name: 'Denver Pizza',
  ),
];

final sizes = <String>['S', 'M', 'L'];
