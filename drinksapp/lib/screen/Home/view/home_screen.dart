import 'package:drinksapp/screen/Ingredient/view/ingredient_screen.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 35,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: Icon(Icons.food_bank_rounded),
                title: Text('Ingredients')),
            BottomNavyBarItem(
                icon: Icon(Icons.local_drink_rounded), title: Text('Drinks')),
            BottomNavyBarItem(
                icon: Icon(Icons.settings), title: Text('Settings')),
          ],
        ),
        body: getBody(_currentIndex));
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return IngredientScreen();
      case 1:
        return Text('Drinks screen');
      default:
        return Text('Settings screen');
    }
  }
}
