import 'package:flutter/material.dart';

import 'package:animatons/pizza_order/ingredient.dart';
import 'package:animatons/pizza_order/pizza.dart';

const _pizzaCartSize = 55.0;

class PizzaOrderDetails extends StatelessWidget {
  final Pizza pizza;
  final Animation<double> transitionAnimation;
  PizzaOrderDetails({
    Key? key,
    required this.pizza,
    required this.transitionAnimation,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'New Orleans Pizza',
          style: TextStyle(
            color: Colors.brown,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            color: Colors.brown,
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 50,
            right: 10,
            left: 10,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: _PizzaDetails(
                      pizza: pizza,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _PizzaIngredients(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            height: _pizzaCartSize,
            width: _pizzaCartSize,
            left: MediaQuery.of(context).size.width / 2 - _pizzaCartSize / 2,
            child: _PizzaCartButton(
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}

class _PizzaDetails extends StatefulWidget {
  final Pizza pizza;
  const _PizzaDetails({
    Key? key,
    required this.pizza,
  }) : super(key: key);
  @override
  __PizzaDetailsState createState() => __PizzaDetailsState();
}

class __PizzaDetailsState extends State<_PizzaDetails>
    with SingleTickerProviderStateMixin {
  final _listIngredients = <Ingredient>[];
  late AnimationController _animationController;
  List<Animation> _animationList = [];
  final _notifierFocused = ValueNotifier(false);
  int _total = 15;
  late BoxConstraints _pizzaConstraints;

  Widget _buildIngredientsWidget() {
    List<Widget> elements = [];

    if (_animationList.isNotEmpty) {
      for (var i = 0; i < _listIngredients.length; i++) {
        Ingredient ingredient = _listIngredients[i];
        final ingredientWidget = Image.asset(ingredient.imageUnit, height: 40);
        for (var j = 0; j < ingredient.positions.length; j++) {
          final animation = _animationList[j];
          final position = ingredient.positions[j];
          final positionX = position.dx;
          final positionY = position.dy;

          if (i == _listIngredients.length - 1) {
            double fromX = 0.0, fromY = 0.0;
            if (j < 1) {
              fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 2) {
              fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
            } else if (j < 4) {
              fromY = -_pizzaConstraints.maxHeight * (1 - animation.value);
            } else {
              fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
            }

            final opacity = animation.value;

            if (animation.value > 0) {
              elements.add(
                Opacity(
                  opacity: opacity,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..translate(
                        fromX + _pizzaConstraints.maxWidth * positionX,
                        fromY + _pizzaConstraints.maxHeight * positionY,
                      ),
                    child: ingredientWidget,
                  ),
                ),
              );
            }
          } else {
            elements.add(
              Transform(
                transform: Matrix4.identity()
                  ..translate(
                    _pizzaConstraints.maxWidth * positionX,
                    _pizzaConstraints.maxHeight * positionY,
                  ),
                child: ingredientWidget,
              ),
            );
          }
        }
      }
      return Stack(
        children: elements,
      );
    }

    return SizedBox.fromSize();
  }

  void _buildIngredientsAnimation() {
    _animationList.clear();
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.8, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.8, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 1.0, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.7, curve: Curves.decelerate),
      ),
    );
    _animationList.add(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 1.0, curve: Curves.decelerate),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DragTarget<Ingredient>(
            onAccept: (ingredient) {
              _notifierFocused.value = false;
              setState(() {
                _total++;
                _listIngredients.add(ingredient);
              });
              _buildIngredientsAnimation();
              _animationController.forward(from: 0.0);
            },
            onWillAccept: (ingredient) {
              print('onWillAccept');
              _notifierFocused.value = true;
              return _listIngredients
                      .indexWhere((i) => i.compare(ingredient!)) ==
                  -1;
            },
            onLeave: (data) {
              _notifierFocused.value = false;
            },
            builder: (context, list, rejects) {
              return LayoutBuilder(builder: (context, constrains) {
                _pizzaConstraints = constrains;
                return Stack(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: _notifierFocused,
                      builder: (context, isFocused, _) {
                        return Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            height: isFocused
                                ? constrains.maxHeight
                                : constrains.maxHeight - 10,
                            child: Hero(
                              tag: widget.pizza.name,
                              child: Material(
                                child: Stack(
                                  children: [
                                    DecoratedBox(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 15.0,
                                              color: Colors.black26,
                                              offset: Offset(0.0, 5.0),
                                              spreadRadius: 5.0,
                                            ),
                                          ],
                                        ),
                                        child: Image.asset(
                                            'assets/pizza_order/dish.png')),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        widget.pizza.image,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, _) {
                        return _buildIngredientsWidget();
                      },
                    ),
                  ],
                );
              });
            },
          ),
        ),
        const SizedBox(height: 5),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                child: child,
                position: animation.drive(
                  Tween<Offset>(
                    begin: Offset(
                      0.0,
                      animation.value,
                    ),
                    end: Offset(0, 0),
                  ),
                ),
              ),
            );
          },
          child: Text(
            '\$$_total',
            key: Key(_total.toString()),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ),
      ],
    );
  }
}

class _PizzaCartButton extends StatefulWidget {
  final VoidCallback onTap;

  const _PizzaCartButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  __PizzaCartButtonState createState() => __PizzaCartButtonState();
}

class __PizzaCartButtonState extends State<_PizzaCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Future<void> _animateButton() async {
    await _animationController.forward(from: 0.0);
    await _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _animateButton();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              colors: [Colors.orange.withOpacity(0.5), Colors.orange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15.0,
                offset: Offset(0.0, 4.0),
                spreadRadius: 4.0,
              ),
            ],
          ),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 35,
          ),
        ),
        builder: (context, child) {
          return Transform.scale(
            scale: 2 - _animationController.value,
            child: child!,
          );
        },
      ),
    );
  }
}

class _PizzaIngredients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        return _PizzaIngredientItem(
          ingredient: ingredient,
        );
      },
    );
  }
}

class _PizzaIngredientItem extends StatelessWidget {
  final Ingredient ingredient;

  const _PizzaIngredientItem({
    Key? key,
    required this.ingredient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: Color(0xFFF5EED3),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            ingredient.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );

    return Center(
      child: Draggable<Ingredient>(
        feedback: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.black26,
                offset: Offset(0.0, 5.0),
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: child,
        ),
        data: ingredient,
        child: child,
      ),
    );
  }
}
