import 'package:animatons/circle_page_transition/core/viewmodels/home_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation startAnimation;
  late Animation endAnimation;
  late Animation horizontalAnimation;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));

    startAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.000, 0.500, curve: Curves.easeInExpo),
    );

    endAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.500, 1.000, curve: Curves.easeOutExpo),
    );

    horizontalAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.750, 1.000, curve: Curves.easeInOutQuad),
    );

    animationController
      ..addStatusListener((status) {
        final model = Provider.of<HomeModel>(context);
        if (status == AnimationStatus.completed) {
          model.swapColors();
          animationController.reset();
        }
      })
      ..addListener(() {
        final model = Provider.of<HomeModel>(context);
        if (animationController.value > 0.5) {
          model.isHalfWay = true;
        } else {
          model.isHalfWay = false;
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
