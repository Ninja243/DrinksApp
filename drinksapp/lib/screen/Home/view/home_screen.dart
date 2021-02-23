import 'package:drinksapp/screen/Ingredient/view/ingredient_screen.dart';
import 'package:drinksapp/screen/Settings/view/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.lightBlue,
        child: SafeArea(
            bottom: true,
            top: true,
            left: true,
            right: true,
            child: Scaffold(
                appBar: AppBar(
                    title: _currentIndex == 1
                        ? TextLiquidFill(
                          
                          loadUntil: 0.67,
                            text: 'Drinks',
                            loadDuration: Duration(seconds: 2),
                            waveColor: Colors.white,
                            boxBackgroundColor: Colors.lightBlue,
                            textStyle: TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.bold,
                            ),
                            boxHeight: 200.0,
                          )
                        : _currentIndex == 2
                            ? TextLiquidFill(
                              loadUntil: 0.67,
                                text: 'Settings',
                                loadDuration: Duration(seconds: 2),
                                waveColor: Colors.white,
                                boxBackgroundColor: Colors.lightBlue,
                                textStyle: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                boxHeight: 200.0,
                              )
                            : TextLiquidFill(
                              loadUntil: 0.67,
                                text: 'Ingredients',
                                loadDuration: Duration(seconds: 2),
                                waveColor: Colors.white,
                                boxBackgroundColor: Colors.lightBlue,
                                textStyle: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                boxHeight: 200.0,
                              )),
                bottomNavigationBar: BottomNavyBar(
                  selectedIndex: _currentIndex,
                  showElevation: true,
                  itemCornerRadius: 35,
                  curve: Curves.easeIn,
                  onItemSelected: (index) =>
                      setState(() => _currentIndex = index),
                  items: <BottomNavyBarItem>[
                    BottomNavyBarItem(
                        icon: Icon(Icons.food_bank_rounded),
                        title: Text('Ingredients')),
                    BottomNavyBarItem(
                        icon: Icon(Icons.local_drink_rounded),
                        title: Text('Drinks')),
                    BottomNavyBarItem(
                        icon: Icon(Icons.settings), title: Text('Settings')),
                  ],
                ),
                body: getBody(_currentIndex))));
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return IngredientScreen();
      case 1:
        return Text('Drinks screen');
      default:
        return SettingsScreen();
    }
  }
}
