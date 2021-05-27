import 'package:animatons/pizza_order/pizza_order_details.dart';
import 'package:flutter/material.dart';
import 'pizza_order_pick_pizza.dart';

class MainPizzaOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: PizzaOrderPickPizza(),
    );
  }
}
