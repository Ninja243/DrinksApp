import 'package:get/get.dart';
import 'package:drinksapp/models/drink.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DrinkController extends GetxController {
  RxList<Drink> _Drinks = <Drink>[].obs;
  SharedPreferences prefs;
  bool _ready = false;

  List<Drink> getDrinks() => _Drinks;

  Drink getDrink(int index) => _Drinks[index];

  bool isReady() => _ready;

  init() async {
    if (this._ready == false) {
      prefs = await SharedPreferences.getInstance();
      var list = prefs.getStringList("Drinks");
      if (list != null) {
        for (var i in list) {
          _Drinks.add(new Drink.fromJson(jsonDecode(i)));
        }
      }
      this._ready = true;
    }
  }

  Future<bool> initWithFuture() =>
      Future.delayed(Duration(seconds: 0), () async {
        if (this._ready == false) {
          prefs = await SharedPreferences.getInstance();
          var list = prefs.getStringList("Drinks");
          if (list != null) {
            for (var i in list) {
              _Drinks.add(new Drink.fromJson(json.decode(i)));
            }
          }
          this._ready = true;
        }
        return this._ready;
      });

  saveList() {
    List<String> l = [];
    for (Drink i in _Drinks) {
      l.add(jsonEncode(i));
    }
    prefs.setStringList("Drinks", l);
  }

  setDrinks(List<Drink> i) {
    this._Drinks.assignAll(i);
    saveList();
  }

  addDrink(Drink i) {
    this._Drinks.add(i);
    saveList();
  }

  clearDrinks() {
    this._Drinks.removeWhere((item) {
      return true;
    });
    prefs.clear();
  }

  deleteDrinkFromIndex(int index) {
    this._Drinks.removeAt(index);
    saveList();
  }

  deleteDrink(Drink Drink) {
    this._Drinks.removeWhere((item) => Drink == item);
    saveList();
  }
}
