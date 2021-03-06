import 'package:get/get.dart';
import 'package:drinksapp/models/ingredient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class IngredientController extends GetxController {
  RxList<Ingredient> _ingredients = <Ingredient>[].obs;
  SharedPreferences prefs;
  bool _ready = false;

  List<Ingredient> getIngredients() => _ingredients;

  Ingredient getIngredient(int index) => _ingredients[index];

  bool isReady() => _ready;

  init() async {
    if (this._ready == false) {
      prefs = await SharedPreferences.getInstance();
      List<String> list = prefs.getStringList("ingredients");
      if (list != null) {
        for (String i in list) {
          _ingredients.add(new Ingredient.fromJson(jsonDecode(i)));
        }
      }
      this._ready = true;
    }
  }

  Future<bool> initWithFuture() =>
      Future.delayed(Duration(seconds: 0), () async {
        if (this._ready == false) {
          prefs = await SharedPreferences.getInstance();
          List<String> list = prefs.getStringList("ingredients");
          if (list != null) {
            for (String i in list) {
              _ingredients.add(new Ingredient.fromJson(json.decode(i)));
            }
          }
          this._ready = true;
        }
        return this._ready;
      });

  saveList() {
    List<String> l = [];
    for (Ingredient i in _ingredients) {
      l.add(jsonEncode(i));
    }
    prefs.setStringList("ingredients", l);
  }

  Ingredient searchByName(String name) {
    return this._ingredients.firstWhere(
        (item) => item.name.toLowerCase().trim().contains(name.toLowerCase()));
  }

  Ingredient searchByPercentage(int max, int min) {
    return this._ingredients.firstWhere(
        (element) => element.percentage >= min && element.percentage <= max);
  }

  List<Ingredient> searchMultipleByPercentage(int max, int min) {
    Iterable<Ingredient> x = this._ingredients.where(
        (element) => element.percentage >= min && element.percentage <= max);
    List<Ingredient> l = <Ingredient>[];
    l.addAll(x);
    return l;
  }

  setIngredients(List<Ingredient> i) {
    this._ingredients.assignAll(i);
    saveList();
  }

  addIngredient(Ingredient i) {
    this._ingredients.add(i);
    saveList();
  }

  clearIngredients() {
    this._ingredients.removeWhere((item) {
      return true;
    });
    prefs.clear();
  }

  deleteIngredientFromIndex(int index) {
    this._ingredients.removeAt(index);
    saveList();
  }

  deleteIngredient(Ingredient ingredient) {
    this._ingredients.removeWhere((item) => ingredient == item);
    saveList();
  }
}
