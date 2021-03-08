import 'package:drinksapp/controller/generator_controller.dart';
import 'package:drinksapp/controller/ingredient_controller.dart';
import 'package:drinksapp/models/drink.dart';
import 'package:drinksapp/models/drink_text.dart';
import 'package:drinksapp/screen/DrinkDetails/view/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:drinksapp/controller/drink_controller.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

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
  bool _connectedToInternet;

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
    try {
      InternetAddress.lookup('google.com').then((res) {
        if (res.isNotEmpty && res[0].rawAddress.isNotEmpty) {
          this._connectedToInternet = true;
        }
      }).catchError((error) {
        if (!(error is SocketException)) {
          print(error.toString());
        }
        this._connectedToInternet = false;
      });
    } on SocketException catch (_) {
      this._connectedToInternet = false;
    }
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
                            if (_connectedToInternet) {
                              return FutureBuilder(
                                future: _drinkGenerator.steal(http.Client()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    snapshot.error.printError();
                                    return Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      Future.delayed(Duration.zero, () {
                                        Navigator.pushNamed(
                                            context, DrinkDetails.routeName,
                                            arguments: DrinkText(
                                                t.name,
                                                t.generateIngredientString(),
                                                t.recipe,
                                                t.percentage));
                                      });
                                      this._displayingDrink = false;
                                      return Align(
                                          alignment: Alignment.topCenter,
                                          child: ListView.builder(
                                              reverse: true,
                                              shrinkWrap: true,
                                              itemCount: _drinkController
                                                  .getDrinks()
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                Drink t = _drinkController
                                                    .getDrink(index);
                                                return ListTile(
                                                  autofocus: true,
                                                  leading: Icon(
                                                      FlutterIcons.drink_ent,
                                                      color: t.percentage > 35
                                                          ? Colors.red
                                                          : t.percentage > 0
                                                              ? Colors.amber
                                                              : Colors.grey),
                                                  title: Text(
                                                      "${t.name} (${t.percentage}%)",
                                                      style: TextStyle(
                                                          color: t.percentage >
                                                                  35
                                                              ? Colors.red
                                                              : t.percentage > 0
                                                                  ? Colors.amber
                                                                  : Colors
                                                                      .black)),
                                                  onTap: () {
                                                    Future.delayed(
                                                        Duration.zero, () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          DrinkDetails
                                                              .routeName,
                                                          arguments: DrinkText(
                                                              t.name,
                                                              t.generateIngredientString(),
                                                              t.recipe,
                                                              t.percentage));
                                                    });
                                                  },
                                                );
                                              }));
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
                                                  _animationController
                                                          .duration =
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
                              return FutureBuilder(
                                future: _drinkGenerator.generate(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    snapshot.error.printError();
                                    return Center(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                      Future.delayed(Duration.zero, () {
                                        Navigator.pushNamed(
                                            context, DrinkDetails.routeName,
                                            arguments: DrinkText(
                                                t.name,
                                                t.generateIngredientString(),
                                                t.recipe,
                                                t.percentage));
                                      });
                                      this._displayingDrink = false;
                                      return Align(
                                          alignment: Alignment.topCenter,
                                          child: ListView.builder(
                                              reverse: true,
                                              shrinkWrap: true,
                                              itemCount: _drinkController
                                                  .getDrinks()
                                                  .length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                Drink t = _drinkController
                                                    .getDrink(index);
                                                return ListTile(
                                                  autofocus: true,
                                                  leading: Icon(
                                                      FlutterIcons.drink_ent,
                                                      color: t.percentage > 35
                                                          ? Colors.red
                                                          : t.percentage > 0
                                                              ? Colors.amber
                                                              : Colors.grey),
                                                  title: Text(
                                                      "${t.name} (${t.percentage}%)",
                                                      style: TextStyle(
                                                          color: t.percentage >
                                                                  35
                                                              ? Colors.red
                                                              : t.percentage > 0
                                                                  ? Colors.amber
                                                                  : Colors
                                                                      .black)),
                                                  onTap: () {
                                                    Future.delayed(
                                                        Duration.zero, () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          DrinkDetails
                                                              .routeName,
                                                          arguments: DrinkText(
                                                              t.name,
                                                              t.generateIngredientString(),
                                                              t.recipe,
                                                              t.percentage));
                                                    });
                                                  },
                                                );
                                              }));
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
                                                  _animationController
                                                          .duration =
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
                            }
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
          body: FutureBuilder(
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
              } else if (snapshot.hasData) {
                return FutureBuilder(
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
                    } else if (snapshot.hasData) {
                      return _drinkController.getDrinks().length > 0
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  itemCount:
                                      _drinkController.getDrinks().length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Drink t = _drinkController.getDrink(index);
                                    return ListTile(
                                      autofocus: true,
                                      leading: Icon(FlutterIcons.drink_ent,
                                          color: t.percentage > 35
                                              ? Colors.red
                                              : t.percentage > 0
                                                  ? Colors.amber
                                                  : Colors.grey),
                                      title:
                                          Text("${t.name} (${t.percentage}%)",
                                              style: TextStyle(
                                                  color: t.percentage > 35
                                                      ? Colors.red
                                                      : t.percentage > 0
                                                          ? Colors.amber
                                                          : Colors.black)),
                                      onTap: () {
                                        Future.delayed(Duration.zero, () {
                                          Navigator.pushNamed(
                                              context, DrinkDetails.routeName,
                                              arguments: DrinkText(
                                                  t.name,
                                                  t.generateIngredientString(),
                                                  t.recipe,
                                                  t.percentage));
                                        });
                                      },
                                    );
                                  }))
                          : GestureDetector(child:Center( child:Container(padding: EdgeInsets.fromLTRB(20, 40, 20, 20),child:Column(
                              children: [
                                Text("Click the plus to mix a drink!",textAlign: TextAlign.center, style: TextStyle(fontSize: 40, )),
                                
                                Expanded(child:Align(alignment: Alignment.bottomCenter, child:Lottie.asset("lib/assets/arrow.json",
                                    controller: _animationController,
                                    onLoaded: (composition) {
                                  _animationController.duration =
                                      composition.duration;
                                  _animationController.forward();
                                },alignment: Alignment.bottomCenter))), 
                              ]),
                            )),onTap: () {
                                    if (_animationController.isCompleted) {
                                      _animationController.reverse();
                                    } else if (_animationController
                                        .isAnimating) {
                                      _animationController.reverse();
                                    } else {
                                      _animationController.forward();
                                    }
                                    
                                  },);
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
                          Text("Getting ingrediboos...")
                        ],
                      ));
                    }
                  },
                  future: _ingredientController.initWithFuture(),
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
                    Text("Getting dranks...")
                  ],
                ));
              }
            },
            future: _drinkController.initWithFuture(),
          ));
    }
  }
}
