import 'package:animatons/coffee_concept/coffee_concept_home.dart';
import 'package:flutter/material.dart';

class MainCoffeeConceptApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: CoffeeConceptHome(),
    );
  }
}
