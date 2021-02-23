import 'dart:convert';
import 'package:drinksapp/controller/settings_controller.dart';
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
  SettingsController _settingsController;

  @override
  void initState() {
    super.initState();
    _settingsController = Get.put(new SettingsController());
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
    _ingredientPercentageController.dispose();
    _ingredientAmountController.dispose();
    //_itemController.saveList();
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
                  if (_settingsController.getActiveBehaviourType() ==
                      GeneratorBehaviourType.UNDER_18) {
                    this._ingredientPercentage = 0;
                    this._ingredientPercentageController.text = "0";
                  }
                  return _settingsController.getActiveBehaviourType() ==
                          GeneratorBehaviourType.UNDER_18
                      ? AlertDialog(
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
                                controller: _ingredientAmountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Bottles available",
                                    suffixIcon: Icon(Feather.package)),
                                onChanged: (value) => this._ingredientAmount =
                                    double.tryParse(value),
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
                                    this._ingredientNameController.text !=
                                        null &&
                                    this._ingredientAmount != 0 &&
                                    double.tryParse(this
                                            ._ingredientAmountController
                                            .text) >
                                        0 &&
                                    double.tryParse(this
                                            ._ingredientPercentageController
                                            .text) >=
                                        0 &&
                                    double.tryParse(this
                                            ._ingredientPercentageController
                                            .text) <=
                                        100 &&
                                    this._ingredientNameController.text != "") {
                                  _itemController.addIngredient(new Ingredient(
                                    _ingredientNameController.text,
                                    _ingredientPercentage,
                                    _ingredientAmount,
                                  ));
                                  Navigator.of(context).pop();
                                } else {
                                  if (this._ingredientAmountController.text ==
                                      "0") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Zu hast no Getränke? 🐦"),
                                    ));
                                  }
                                  if (this._ingredientAmountController.text ==
                                          null ||
                                      this._ingredientAmountController.text ==
                                          "") {
                                    this._ingredientAmountController.text = "0";
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Gib me eine Menge please"),
                                    ));
                                  }
                                  if (this
                                              ._ingredientPercentageController
                                              .text ==
                                          null ||
                                      this
                                              ._ingredientPercentageController
                                              .text ==
                                          "") {
                                    this._ingredientPercentageController.text =
                                        "0";
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Please add an alcohol percentage."),
                                    ));
                                  }

                                  if (double.tryParse(this
                                          ._ingredientPercentageController
                                          .text) >
                                      100) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "There's no way this is more than 100% alcohol")));
                                  }
                                  if (double.tryParse(this
                                              ._ingredientPercentageController
                                              .text) <
                                          0 ||
                                      double.tryParse(this
                                              ._ingredientAmountController
                                              .text) <
                                          0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("Hö 🧐")));
                                  }
                                  if (this._ingredientNameController.text ==
                                      "") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Add a name, dummy 🙄")));
                                  }
                                }
                              },
                            ),
                          ],
                        )
                      : AlertDialog(
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
                                onChanged: (value) =>
                                    this._ingredientPercentage =
                                        double.tryParse(value),
                              ),
                              TextField(
                                controller: _ingredientAmountController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: "Bottles available",
                                    suffixIcon: Icon(Feather.package)),
                                onChanged: (value) => this._ingredientAmount =
                                    double.tryParse(value),
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
                                    this._ingredientNameController.text !=
                                        null &&
                                    this._ingredientAmount != 0 &&
                                    double.tryParse(this
                                            ._ingredientAmountController
                                            .text) >
                                        0 &&
                                    double.tryParse(this
                                            ._ingredientPercentageController
                                            .text) >=
                                        0 &&
                                    double.tryParse(this
                                            ._ingredientPercentageController
                                            .text) <=
                                        100 &&
                                    this._ingredientNameController.text != "") {
                                  _itemController.addIngredient(new Ingredient(
                                    _ingredientNameController.text,
                                    _ingredientPercentage,
                                    _ingredientAmount,
                                  ));
                                  Navigator.of(context).pop();
                                } else {
                                  if (this._ingredientAmountController.text ==
                                      "0") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "You're really trying to add something you have none of? 🐦"),
                                    ));
                                  }
                                  if (this._ingredientAmountController.text ==
                                          null ||
                                      this._ingredientAmountController.text ==
                                          "") {
                                    this._ingredientAmountController.text = "0";
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Please add an amount"),
                                    ));
                                  }
                                  if (this
                                              ._ingredientPercentageController
                                              .text ==
                                          null ||
                                      this
                                              ._ingredientPercentageController
                                              .text ==
                                          "") {
                                    this._ingredientPercentageController.text =
                                        "0";
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Please add an alcohol percentage."),
                                    ));
                                  }

                                  if (double.tryParse(this
                                          ._ingredientPercentageController
                                          .text) >
                                      100) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "There's no way this is more than 100% alcohol")));
                                  }
                                  if (double.tryParse(this
                                              ._ingredientPercentageController
                                              .text) <
                                          0 ||
                                      double.tryParse(this
                                              ._ingredientAmountController
                                              .text) <
                                          0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("What the fuck 🧐")));
                                  }
                                  if (this._ingredientNameController.text ==
                                      "") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Add a name, ya dingus 🙄")));
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
                          if (_settingsController.getActiveBehaviourType() ==
                              GeneratorBehaviourType.UNDER_18) {
                            if (_itemController.getIngredient(index).itype !=
                                IngredientType.NON_ALCOHOLIC_DRINK) {
                              return SizedBox();
                            }
                          }
                          return ListTile(
                            title: Text(
                                "${_itemController.getIngredient(index).name} (${_itemController.getIngredient(index).percentage}%)",
                                style: TextStyle(
                                  color: _itemController
                                              .getIngredient(index)
                                              .itype ==
                                          IngredientType.STRONG_ALCOHOLIC_DRINK
                                      ? Colors.red
                                      : _itemController
                                                  .getIngredient(index)
                                                  .itype ==
                                              IngredientType
                                                  .WEAK_ALCOHOLIC_DRINK
                                          ? Colors.amber
                                          : Colors.black,
                                )),
                            subtitle: Text(
                                "${_itemController.getIngredient(index).itype}"),
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
                                    if (_settingsController
                                            .getActiveBehaviourType() ==
                                        GeneratorBehaviourType.UNDER_18) {
                                      this._ingredientPercentage = 0;
                                      this
                                          ._ingredientPercentageController
                                          .text = "0";
                                    }
                                    return _settingsController
                                                .getActiveBehaviourType() ==
                                            GeneratorBehaviourType.UNDER_18
                                        ? AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller:
                                                      _ingredientNameController,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Ingredient name",
                                                      suffixIcon: Icon(
                                                          Feather.at_sign)),
                                                ),
                                                TextField(
                                                  controller:
                                                      _ingredientAmountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Bottles available",
                                                      suffixIcon: Icon(
                                                          Feather.package)),
                                                  onChanged: (value) => this
                                                          ._ingredientAmount =
                                                      double.tryParse(value),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text("Cancel",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.redAccent)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                  child: Text("Update"),
                                                  onPressed: () {
                                                    this._ingredientPercentage =
                                                        0;
                                                    this
                                                        ._ingredientPercentageController
                                                        .text = "0";
                                                    this._ingredientAmount =
                                                        double.tryParse(
                                                            _ingredientAmountController
                                                                .text);
                                                    this._ingredientPercentage =
                                                        double.tryParse(
                                                            _ingredientPercentageController
                                                                .text);
                                                    if (this._ingredientAmountController.text != null &&
                                                        this
                                                                ._ingredientPercentageController
                                                                .text !=
                                                            null &&
                                                        this
                                                                ._ingredientNameController
                                                                .text !=
                                                            null &&
                                                        double.tryParse(this
                                                                ._ingredientAmountController
                                                                .text) !=
                                                            0 &&
                                                        double.tryParse(this
                                                                ._ingredientPercentageController
                                                                .text) >=
                                                            0 &&
                                                        double.tryParse(this
                                                                ._ingredientPercentageController
                                                                .text) <=
                                                            100 &&
                                                        this
                                                                ._ingredientNameController
                                                                .text !=
                                                            "") {
                                                      _itemController
                                                          .getIngredient(index)
                                                          .updateData(
                                                              this
                                                                  ._ingredientNameController
                                                                  .text,
                                                              double.tryParse(this
                                                                  ._ingredientPercentageController
                                                                  .text),
                                                              double.tryParse(this
                                                                  ._ingredientAmountController
                                                                  .text));
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      if (this
                                                              ._ingredientAmountController
                                                              .text ==
                                                          "0") {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "But zyew hast none?"),
                                                        ));
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
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Please add ze menge"),
                                                        ));
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
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Please add an alcohol percentage."),
                                                        ));
                                                      }
                                                      if (this
                                                                  ._ingredientNameController
                                                                  .text ==
                                                              null ||
                                                          this
                                                                  ._ingredientNameController
                                                                  .text ==
                                                              "") {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Zyew hast none of zis Getränk?"),
                                                        ));
                                                      }
                                                      if (double.tryParse(this
                                                              ._ingredientPercentageController
                                                              .text) >
                                                          100) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "Zere ist no way it ist über 100%")));
                                                      }
                                                      if (double.tryParse(this
                                                                  ._ingredientPercentageController
                                                                  .text) <
                                                              0 ||
                                                          double.tryParse(this
                                                                  ._ingredientAmountController
                                                                  .text) <
                                                              0) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "Hö 🧐")));
                                                      }
                                                      if (this
                                                              ._ingredientNameController
                                                              .text ==
                                                          "") {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "Add a name, dumb dumb 🙄")));
                                                      }
                                                    }
                                                  }),
                                            ],
                                          )
                                        : AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                TextField(
                                                  controller:
                                                      _ingredientNameController,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Ingredient name",
                                                      suffixIcon: Icon(
                                                          Feather.at_sign)),
                                                ),
                                                TextField(
                                                  controller:
                                                      _ingredientPercentageController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Alc. Percentage",
                                                      suffixIcon: Icon(
                                                          Feather.percent)),
                                                  onChanged: (value) => this
                                                          ._ingredientPercentage =
                                                      double.tryParse(value),
                                                ),
                                                TextField(
                                                  controller:
                                                      _ingredientAmountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          "Bottles available",
                                                      suffixIcon: Icon(
                                                          Feather.package)),
                                                  onChanged: (value) => this
                                                          ._ingredientAmount =
                                                      double.tryParse(value),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                child: Text("Cancel",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.redAccent)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                  child: Text("Update"),
                                                  onPressed: () {
                                                    this._ingredientAmount =
                                                        double.tryParse(
                                                            _ingredientAmountController
                                                                .text);
                                                    this._ingredientPercentage =
                                                        double.tryParse(
                                                            _ingredientPercentageController
                                                                .text);
                                                    if (this._ingredientAmountController.text != null &&
                                                        this
                                                                ._ingredientPercentageController
                                                                .text !=
                                                            null &&
                                                        this
                                                                ._ingredientNameController
                                                                .text !=
                                                            null &&
                                                        double.tryParse(this
                                                                ._ingredientAmountController
                                                                .text) !=
                                                            0 &&
                                                        double.tryParse(this
                                                                ._ingredientPercentageController
                                                                .text) >=
                                                            0 &&
                                                        double.tryParse(this
                                                                ._ingredientPercentageController
                                                                .text) <=
                                                            100 &&
                                                        this
                                                                ._ingredientNameController
                                                                .text !=
                                                            "") {
                                                      _itemController
                                                          .getIngredient(index)
                                                          .updateData(
                                                              this
                                                                  ._ingredientNameController
                                                                  .text,
                                                              double.tryParse(this
                                                                  ._ingredientPercentageController
                                                                  .text),
                                                              double.tryParse(this
                                                                  ._ingredientAmountController
                                                                  .text));
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      if (this
                                                              ._ingredientAmountController
                                                              .text ==
                                                          "0") {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "You're really trying to add something you have none of? 🐦"),
                                                        ));
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
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Please add an amount"),
                                                        ));
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
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "Please add an alcohol percentage."),
                                                        ));
                                                      }
                                                      if (this
                                                                  ._ingredientNameController
                                                                  .text ==
                                                              null ||
                                                          this
                                                                  ._ingredientNameController
                                                                  .text ==
                                                              "") {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                              "You're really trying to add something you have none of? 🐦"),
                                                        ));
                                                      }
                                                      if (double.tryParse(this
                                                              ._ingredientPercentageController
                                                              .text) >
                                                          100) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "There's no way this is more than 100% alcohol")));
                                                      }
                                                      if (double.tryParse(this
                                                                  ._ingredientPercentageController
                                                                  .text) <
                                                              0 ||
                                                          double.tryParse(this
                                                                  ._ingredientAmountController
                                                                  .text) <
                                                              0) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "What the fuck 🧐")));
                                                      }
                                                      if (this
                                                              ._ingredientNameController
                                                              .text ==
                                                          "") {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    "Add a name, ya dingus 🙄")));
                                                      }
                                                    }
                                                  }),
                                            ],
                                          );
                                  });
                            },
                            trailing: GestureDetector(
                              child: Icon(FlutterIcons.trash_2_fea),
                              onTap: () {
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
                            ),
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
                                child: _settingsController
                                            .getActiveBehaviourType() ==
                                        GeneratorBehaviourType.UNDER_18
                                    ? Lottie.asset('lib/assets/baby.json',
                                        controller: _animationController,
                                        onLoaded: (composition) {
                                        _animationController.duration =
                                            composition.duration;
                                        _animationController.repeat();
                                      })
                                    : Lottie.asset(
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
