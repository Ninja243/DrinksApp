import 'package:drinksapp/controller/generator_controller.dart';
import 'package:drinksapp/controller/ingredient_controller.dart';
import 'package:drinksapp/models/drink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:drinksapp/controller/drink_controller.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:lottie/lottie.dart';

class DrinkScreen extends StatefulWidget {
  @override
  _DrinkScreenState createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen>
    with SingleTickerProviderStateMixin {
  IngredientController _ingredientController;
  DrinkController _drinkController;
  DrinkGenerator _drinkGenerator;
  AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _displayingDrink = false;

  @override
  void initState() {
    super.initState();
    _ingredientController = Get.put(new IngredientController());
    _drinkController = Get.put(new DrinkController());
    _drinkGenerator = Get.put(new DrinkGenerator());
    _animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (_displayingDrink) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(
              FlutterIcons.ios_arrow_back_ion,
              color: Colors.white,
            ),
            onPressed: () {
              this._displayingDrink = false;
              setState(() {});
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          body: FutureBuilder(
            future: _drinkController.initWithFuture(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                snapshot.error.printError();
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Lottie.asset('lib/assets/error.json',
                              controller: _animationController,
                              onLoaded: (composition) {
                            _animationController.duration =
                                composition.duration;
                            _animationController.repeat();
                          }),
                        )
                      ],
                    ),
                    Text(snapshot.error.toString())
                    //Text("Nothing's here yet!")
                  ],
                ));
              } else {
                if (snapshot.hasData) {
                  return FutureBuilder(
                      future: _drinkGenerator.initWithFuture(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          snapshot.error.printError();
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Lottie.asset('lib/assets/error.json',
                                        controller: _animationController,
                                        onLoaded: (composition) {
                                      _animationController.duration =
                                          composition.duration;
                                      _animationController.repeat();
                                    }),
                                  )
                                ],
                              ),
                              Text(snapshot.error.toString())
                              //Text("Nothing's here yet!")
                            ],
                          ));
                        } else {
                          if (snapshot.hasData) {
                            return FutureBuilder(
                              future: _drinkGenerator.generate(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  snapshot.error.printError();
                                  return Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Lottie.asset(
                                                'lib/assets/error.json',
                                                controller:
                                                    _animationController,
                                                onLoaded: (composition) {
                                              _animationController.duration =
                                                  composition.duration;
                                              _animationController.repeat();
                                            }),
                                          )
                                        ],
                                      ),
                                      Text(snapshot.error.toString())
                                      //Text("Nothing's here yet!")
                                    ],
                                  ));
                                } else {
                                  if (snapshot.hasData) {
                                    Drink t = snapshot.data;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          t.name,
                                          style: TextStyle(
                                              fontSize: 70.0,
                                              fontFamily: "Canterbury"),
                                        ),
                                        Text(t.generateIngredientString()),
                                        Text(t.recipe)
                                      ],
                                    );
                                  } else {
                                    return Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Lottie.asset(
                                                  'lib/assets/loading.json',
                                                  controller:
                                                      _animationController,
                                                  onLoaded: (composition) {
                                                _animationController.duration =
                                                    composition.duration;
                                                _animationController.repeat();
                                              }),
                                            )
                                          ],
                                        ),
                                        Text(
                                            "Beep boop, I'm putting toes in your soup...")
                                      ],
                                    ));
                                  }
                                }
                              },
                            );
                          } else {
                            return Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Lottie.asset(
                                          'lib/assets/loading.json',
                                          controller: _animationController,
                                          onLoaded: (composition) {
                                        _animationController.duration =
                                            composition.duration;
                                        _animationController.repeat();
                                      }),
                                    )
                                  ],
                                ),
                                Text(
                                    "Starting super high-tech AI drink generation algorithm...")
                              ],
                            ));
                          }
                        }
                      });
                } else {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Lottie.asset('lib/assets/loading.json',
                                controller: _animationController,
                                onLoaded: (composition) {
                              _animationController.duration =
                                  composition.duration;
                              _animationController.repeat();
                            }),
                          )
                        ],
                      ),
                      Text("Beep boop, I'm putting toes in your soup...")
                    ],
                  ));
                }
              }
            },
          ));
    } else {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              this._displayingDrink = true;
              setState(() {});
            },
          ),
          body: ListView.builder(
              itemCount: _drinkController.getDrinks().length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionCard(
                  title: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${_drinkController.getDrink(index).name} (${_drinkController.getDrink(index).percentage}%)",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Sub",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              }));
    }
  }
}
