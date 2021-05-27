import 'package:animatons/circle_page_transition/core/viewmodels/home_model.dart';
import 'package:animatons/circle_page_transition/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCirclePageTransition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      child: HomeView(),
    );
  }
}
