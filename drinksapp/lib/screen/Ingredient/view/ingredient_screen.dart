import 'dart:convert';
import 'package:drinksapp/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:drinksapp/common/enums.dart';
import 'package:drinksapp/controller/ingredient_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:drinksapp/controller/storage_controller.dart';

class IngredientScreen extends StatefulWidget {
  @override
  _IngredientScreenState createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen>
    with SingleTickerProviderStateMixin {
  IngredientController _itemController;
  TextEditingController _ingredientNameController;
  TextEditingController _ingredientPercentageController;
  TextEditingController _ingredientAmountController;
  double _ingredientPercentage;
  double _ingredientAmount;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _itemController = Get.put(new IngredientController());
    _ingredientPercentageController = TextEditingController();
    _ingredientAmountController = TextEditingController();
    _ingredientNameController = TextEditingController();
    _ingredientPercentage = 0;
    _ingredientAmount = 0;
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _ingredientNameController.dispose();
    _ingredientPercentageController.dispose();
    _ingredientAmountController.dispose();
    _itemController.saveList();
    _itemController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Add Ingredient"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _ingredientNameController,
                          decoration: InputDecoration(
                              hintText: "Ingredient name",
                              suffixIcon: Icon(Feather.at_sign)),
                        ),
                        TextField(
                          controller: _ingredientPercentageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Alc. Percentage",
                              suffixIcon: Icon(Feather.percent)),
                          onChanged: (value) => this._ingredientPercentage =
                              double.tryParse(value),
                        ),
                        TextField(
                          controller: _ingredientAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Bottles available",
                              suffixIcon: Icon(Feather.package)),
                          onChanged: (value) =>
                              this._ingredientAmount = double.tryParse(value),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Add"),
                        onPressed: () {
                          if (this._ingredientAmount != null &&
                              this._ingredientPercentage != null &&
                              this._ingredientNameController.text != null &&
                              this._ingredientAmount != 0 &&
                              this._ingredientNameController.text != "") {
                            _itemController.addIngredient(new Ingredient(
                              _ingredientNameController.text,
                              _ingredientPercentage,
                              _ingredientAmount,
                            ));
                            Navigator.of(context).pop();
                          } else {
                            if (this._ingredientAmountController.text == "0") {
                              this._ingredientAmountController.text =
                                  "You're really trying to add something you have none of? 🐦";
                            }
                            if (this
                                ._ingredientAmountController
                                .text
                                .startsWith("-")) {
                              this._ingredientAmountController.text = "No";
                            }
                            if (this
                                ._ingredientPercentageController
                                .text
                                .startsWith("-")) {
                              this._ingredientPercentageController.text = "No";
                            }
                            if (this._ingredientAmountController.text == null ||
                                this._ingredientAmountController.text == "") {
                              this._ingredientAmountController.text = "0";
                            }
                            if (this._ingredientPercentageController.text ==
                                    null ||
                                this._ingredientPercentageController.text ==
                                    "") {
                              this._ingredientPercentageController.text = "0";
                            }
                            if (this._ingredientNameController.text == null ||
                                this._ingredientNameController.text == "") {
                              this._ingredientNameController.text =
                                  "Add a drink name, ya dingus";
                            }
                          }
                        },
                      ),
                    ],
                  );
                });
          },
        ),
        body: FutureBuilder(
          initialData: false,
          future: _itemController.initWithFuture(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
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
                          _animationController.duration = composition.duration;
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
              return Obx(() {
                return _itemController.getIngredients().length > 0
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                "${_itemController.getIngredient(index).name} (${_itemController.getIngredient(index).percentage}%)"),
                            subtitle: Text(
                                "${_itemController.getIngredient(index).itype}"),
                            tileColor: _itemController
                                        .getIngredient(index)
                                        .itype ==
                                    IngredientType.STRONG_ALCOHOLIC_DRINK
                                ? Colors.red
                                : _itemController.getIngredient(index).itype ==
                                        IngredientType.WEAK_ALCOHOLIC_DRINK
                                    ? Colors.amber
                                    : Colors.white,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    _ingredientNameController.text =
                                        _itemController
                                            .getIngredient(index)
                                            .name;
                                    _ingredientAmountController.text =
                                        _itemController
                                            .getIngredient(index)
                                            .amountAvailable
                                            .toString();
                                    _ingredientPercentageController.text =
                                        _itemController
                                            .getIngredient(index)
                                            .percentage
                                            .toString();
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller:
                                                _ingredientNameController,
                                            decoration: InputDecoration(
                                                hintText: "Ingredient name",
                                                suffixIcon:
                                                    Icon(Feather.at_sign)),
                                          ),
                                          TextField(
                                            controller:
                                                _ingredientPercentageController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: "Alc. Percentage",
                                                suffixIcon:
                                                    Icon(Feather.percent)),
                                            onChanged: (value) =>
                                                this._ingredientPercentage =
                                                    double.tryParse(value),
                                          ),
                                          TextField(
                                            controller:
                                                _ingredientAmountController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                hintText: "Bottles available",
                                                suffixIcon:
                                                    Icon(Feather.package)),
                                            onChanged: (value) =>
                                                this._ingredientAmount =
                                                    double.tryParse(value),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text("Cancel",
                                              style: TextStyle(
                                                  color: Colors.redAccent)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                            child: Text("Update"),
                                            onPressed: () {
                                              if (this._ingredientAmount !=
                                                      null &&
                                                  this._ingredientPercentage !=
                                                      null &&
                                                  this
                                                          ._ingredientNameController
                                                          .text !=
                                                      null &&
                                                  this._ingredientAmount != 0 &&
                                                  this
                                                          ._ingredientNameController
                                                          .text !=
                                                      "") {
                                                _itemController
                                                        .getIngredient(index)
                                                        .name =
                                                    this
                                                        ._ingredientNameController
                                                        .text;
                                                _itemController
                                                        .getIngredient(index)
                                                        .percentage =
                                                    this._ingredientPercentage;
                                                _itemController
                                                        .getIngredient(index)
                                                        .amountAvailable =
                                                    _ingredientAmount;
                                                _itemController
                                                    .getIngredient(index)
                                                    .update();
                                                setState(() {});
                                                Navigator.of(context).pop();
                                              } else {
                                                if (this
                                                        ._ingredientAmountController
                                                        .text ==
                                                    "0") {
                                                  this
                                                          ._ingredientAmountController
                                                          .text =
                                                      "You're really trying to add something you have none of? 🐦";
                                                }
                                                if (this
                                                            ._ingredientAmountController
                                                            .text ==
                                                        null ||
                                                    this
                                                            ._ingredientAmountController
                                                            .text ==
                                                        "") {
                                                  this
                                                      ._ingredientAmountController
                                                      .text = "0";
                                                }
                                                if (this
                                                            ._ingredientPercentageController
                                                            .text ==
                                                        null ||
                                                    this
                                                            ._ingredientPercentageController
                                                            .text ==
                                                        "") {
                                                  this
                                                      ._ingredientPercentageController
                                                      .text = "0";
                                                }
                                                if (this
                                                            ._ingredientNameController
                                                            .text ==
                                                        null ||
                                                    this
                                                            ._ingredientNameController
                                                            .text ==
                                                        "") {
                                                  this
                                                          ._ingredientNameController
                                                          .text =
                                                      "Add a drink name, ya dingus";
                                                }
                                              }
                                            }),
                                      ],
                                    );
                                  });
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Would you really like to delete ${_itemController.getIngredient(index).name}?"),
                                      actions: [
                                        TextButton(
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                  color: Colors.redAccent),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }),
                                        TextButton(
                                            child: Text(
                                              "Yeah",
                                            ),
                                            onPressed: () {
                                              _itemController
                                                  .deleteIngredientFromIndex(
                                                      index);
                                              Navigator.of(context).pop();
                                            })
                                      ],
                                    );
                                  });
                            },
                          );
                        },
                        itemCount: _itemController.getIngredients().length,
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Lottie.asset(
                                    'lib/assets/empty_bottles.json',
                                    controller: _animationController,
                                    onLoaded: (composition) {
                                  _animationController.duration =
                                      composition.duration;
                                  _animationController.repeat();
                                }),
                              )
                            ],
                          ),
                          Text("Nothing's here yet!")
                        ],
                      ));
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
                          _animationController.duration = composition.duration;
                          _animationController.repeat();
                        }),
                      )
                    ],
                  ),
                  //Text("Nothing's here yet!")
                ],
              ));
            }
          },
        ));
  }
}
