import 'package:animatons/circle_page_transition/circle_page_transition.dart';
import 'package:flutter/material.dart';

import 'package:animatons/coffee_concept/main_coffee_concept_app.dart';
import 'package:animatons/pizza_order/main_pizza_order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PickProjectPage(),
    );
  }
}

class PickProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _SelectProjectButton(
              projectMain: MainCoffeeConceptApp(),
              title: 'Coffee App Concept',
            ),
            _SelectProjectButton(
              projectMain: MainPizzaOrder(),
              title: 'Pizza Order',
            ),
            _SelectProjectButton(
              projectMain: MainCirclePageTransition(),
              title: 'Circle Page Transition',
            )
          ],
        ),
      ),
    );
  }
}

class _SelectProjectButton extends StatelessWidget {
  final Widget projectMain;
  final String title;

  const _SelectProjectButton({
    Key? key,
    required this.projectMain,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10,
      color: Colors.blue,
      onPressed: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: projectMain,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        ));
      },
      child: Text(title),
    );
  }
}
