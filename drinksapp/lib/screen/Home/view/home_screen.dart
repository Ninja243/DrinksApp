import 'package:drinksapp/common/enums.dart';
import 'package:drinksapp/controller/ingredient_controller.dart';
import 'package:drinksapp/screen/Ingredient/view/ingredient_screen.dart';
import 'package:drinksapp/screen/Settings/view/settings_screen.dart';
import 'package:drinksapp/screen/Drink/view/drink_screen.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:drinksapp/controller/settings_controller.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  SettingsController _settingsController;
  IngredientController _itemController;

  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _itemController = Get.put(new IngredientController());
    _settingsController = Get.put(new SettingsController());
  }

  @override
  void dispose() {
    _itemController.dispose();
    _settingsController.dispose();
    super.dispose();
  }

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
                    centerTitle: true,
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
                  items: _settingsController.getActiveBehaviourType() ==
                          GeneratorBehaviourType.UNDER_18
                      ? <BottomNavyBarItem>[
                          BottomNavyBarItem(
                              icon: Icon(FlutterIcons.utensil_spoon_faw5s),
                              title: Text('Ingredients')),
                          BottomNavyBarItem(
                              icon: Icon(FlutterIcons.baby_bottle_mco),
                              title: Text('Drinks')),
                          BottomNavyBarItem(
                              icon: Icon(Icons.settings),
                              title: Text('Settings')),
                        ]
                      : <BottomNavyBarItem>[
                          BottomNavyBarItem(
                              icon: Icon(FlutterIcons.bottle_wine_mco),
                              title: Text('Ingredients')),
                          BottomNavyBarItem(
                              icon: Icon(FlutterIcons.glass_cocktail_mco),
                              title: Text('Drinks')),
                          BottomNavyBarItem(
                              icon: Icon(Icons.settings),
                              title: Text('Settings')),
                        ],
                ),
                body: getBody(_currentIndex))));
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return IngredientScreen();
      case 1:
        return DrinkScreen();
      default:
        return SettingsScreen();
    }
  }
}
