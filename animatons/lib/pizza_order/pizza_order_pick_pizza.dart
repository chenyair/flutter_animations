import 'dart:math';

import 'package:animatons/pizza_order/pizza_order_details.dart';
import 'package:flutter/material.dart';
import 'pizza.dart';

class PizzaOrderPickPizza extends StatefulWidget {
  PizzaOrderPickPizza({Key? key}) : super(key: key);

  @override
  _PizzaOrderPickPizzaState createState() => _PizzaOrderPickPizzaState();
}

const _initialPage = 1;

class _PizzaOrderPickPizzaState extends State<PizzaOrderPickPizza> {
  PageController _pageController = PageController(
    initialPage: _initialPage,
    viewportFraction: 0.5,
  );

  double _currentPage = _initialPage.toDouble();
  Pizza _currentPizza = pizzas[_initialPage];

  void _pageChangeListener() {
    setState(() {
      _currentPage = _pageController.page!;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_pageChangeListener);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.brown,
                size: 32,
              ),
            ),
          ],
          leadingWidth: 10,
          title: Stack(
            children: [
              Text(
                'Order Manually',
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      BoxShadow(color: Colors.black26, offset: Offset(1.5, 2.3))
                    ]),
              ),
              Text(
                'Order Manually',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 0.3
                    ..color = Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey[200]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.brown),
                          Text(
                            'Washington Park',
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFDA6B),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Pizza',
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                flex: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 8,
                child: Stack(
                  children: [
                    Positioned(
                      top: size.height * 0.1,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Hero(
                          tag: 'card',
                          child: Material(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: size.height * 0.6,
                              width: size.width * 0.55,
                              child: Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.15,
                                    ),
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      transitionBuilder: (child, animation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: SlideTransition(
                                            position: animation.drive(
                                              Tween<Offset>(
                                                begin: Offset(0.0,
                                                    -(1 - animation.value)),
                                                end: Offset(0.0, 0.0),
                                              ),
                                            ),
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        _currentPizza.name,
                                        key: Key(_currentPizza.name),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22,
                                          color: Colors.brown,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          5,
                                          (index) {
                                            final color = Color(0xFFCB6E4B);
                                            return Icon(
                                              Icons.star,
                                              size: 20,
                                              color: index < _currentPizza.stars
                                                  ? color
                                                  : color.withOpacity(0.5),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$${_currentPizza.price}',
                                      style: TextStyle(
                                        color: Color(0xFF6C3C40),
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: sizes
                                          .map(
                                            (pizzaSize) => Container(
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  if (pizzaSize == 'M')
                                                    BoxShadow(
                                                      offset: Offset(0, 2),
                                                      color: Colors.black12,
                                                      spreadRadius: 1,
                                                      blurRadius: 3,
                                                    )
                                                ],
                                                shape: BoxShape.circle,
                                              ),
                                              child: Text(
                                                pizzaSize,
                                                style: TextStyle(
                                                  color: Colors.brown,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Hero(
                      tag: _currentPizza.name,
                      child: Material(
                        child: Stack(        
                          children: [
                            Positioned(
                              top: 5,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 20,
                                        offset: Offset(0, 20),
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'assets/pizza_order/dish.png',
                                    height: 270,
                                  ),
                                ),
                              ),
                            ),
                            PageView.builder(
                              key: PageStorageKey('pizza-list'),
                              onPageChanged: (page) =>
                                  _currentPizza = pizzas[page],
                              pageSnapping: true,
                              itemCount: pizzas.length,
                              itemBuilder: (context, index) {
                                final value = index - _currentPage;
                                final y = -pow(value, 2) + 1;
                                return Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.identity()
                                          ..translate(
                                            0.0,
                                            (1 - y) * size.height * 0.3,
                                          )
                                          ..scale(
                                              (0.8 * y + 0.7).clamp(0.0, 3.0))
                                          ..rotateZ(pi / 3 * (1 - y)),
                                        child: GestureDetector(
                                            onTap: () => _itemClicked(index),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Image.asset(
                                                  pizzas[index].image),
                                            )),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              controller: _pageController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: size.height * 0.08,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFE7F47).withOpacity(0.5),
                                offset: Offset(0.0, 10.0),
                                blurRadius: 5,
                              )
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFFFD86A), Color(0xFFFE7F47)],
                            ),
                          ),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _itemClicked(int index) {
    if (_currentPage.toInt() == index) {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) {
            return PizzaOrderDetails(
              transitionAnimation: animation,
              pizza: _currentPizza,
            );
          },
        ),
      );
    } else {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
