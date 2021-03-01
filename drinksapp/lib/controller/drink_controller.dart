import 'package:get/get.dart';
import 'package:drinksapp/models/drink.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DrinkController extends GetxController {
  RxList<Drink> _drinks = <Drink>[].obs;
  SharedPreferences prefs;
  bool _ready = false;

  List<Drink> getDrinks() => _drinks;

  Drink getDrink(int index) => _drinks[index];

  bool isReady() => _ready;

  init() async {
    if (this._ready == false) {
      prefs = await SharedPreferences.getInstance();
      List<String> list = prefs.getStringList("Drinks");
      if (list != null) {
        for (String i in list) {
          _drinks.add(new Drink.fromJson(jsonDecode(i)));
        }
      }
      this._ready = true;
    }
  }

  Future<bool> initWithFuture() {
    //print("1");
    return Future.delayed(Duration(seconds: 0), () async {
      //print("2");
      if (this._ready == false) {
        prefs = await SharedPreferences.getInstance();
        //print("3");
        List<String> list = prefs.getStringList("Drinks");
        //print("4");
        if (list != null) {
          //print("4.2");
          for (String i in list) {
            //print("4.5");
            //print(i);
            Map<String, dynamic> x = json.decode(i);
            //print(x);
            Drink d = new Drink.fromJson(x);
            //print(d);
            _drinks.add(d);
            //print("5");
          }
        }
        //print("6");
        this._ready = true;
      }
      //print("Drink controller future finished");
      return true;
    });
  }

  saveList() {
    List<String> l = [];
    for (Drink i in _drinks) {
      l.add(jsonEncode(i));
    }
    prefs.setStringList("Drinks", l);
  }

  setDrinks(List<Drink> i) {
    this._drinks.assignAll(i);
    saveList();
  }

  addDrink(Drink i) {
    this._drinks.add(i);
    saveList();
  }

  clearDrinks() {
    this._drinks.removeWhere((item) {
      return true;
    });
    prefs.clear();
  }

  deleteDrinkFromIndex(int index) {
    this._drinks.removeAt(index);
    saveList();
  }

  deleteDrink(Drink drink) {
    this._drinks.removeWhere((item) => drink == item);
    saveList();
  }
}
