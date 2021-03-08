import 'dart:convert';

import 'package:drinksapp/common/enums.dart';
import 'package:drinksapp/controller/ingredient_controller.dart';
import 'package:drinksapp/controller/settings_controller.dart';
import 'package:drinksapp/controller/drink_controller.dart';
import 'package:drinksapp/models/drink.dart';
import 'package:drinksapp/models/ingredient.dart';
import 'package:drinksapp/models/recipeGPT_message.dart';
import "package:get/get.dart";
import 'package:http/http.dart' as http;
import 'package:requests/requests.dart';

class DrinkGenerator {
  IngredientController _ingredientController;
  SettingsController _settingsController;
  DrinkController _drinkController;
  bool isReady = false;
  int _drinksGenerated = 0;
  List<String> _colors = [
    "Neon",
    "Green",
    "Black",
    "Blue",
    "Red",
    "Pink",
    "See-through",
    "Oily"
  ];
  List<String> _places = ["Regensburg", "German", "Namibian", "Minnasota"];
  List<String> _nouns = [
    "Polisher",
    "Shoe",
    "Bag",
    "Hammer",
    "Drill",
    "Brick",
    "Banger"
  ];
  List<String> _closingPhrases = [
    'Bon Appetit!',
    'Sauf mit Verantwortung!',
    'Enjoy responsibly!',
    "Don't puke on the carpet!",
    "Feel free to throw this one down the sink if no one's looking.",
    "Prost!",
    "Chin-Chin!",
    "здоровье! (Nastrovie!)",
    "Auf X!",
    "За Советский Союз! (Za Sovetskiy Soyuz!)"
  ];
  List<String> _unitPreparationMethods = [
    "shaking",
    "stirring",
    "boiling",
    "flash-freezing and thawing"
  ];
  List<String> _unitPrePreparationMethods = [
    "shake",
    "stir",
    "boil",
    "flash-freeze and thaw"
  ];
  List<String> _unitPostPreparationMethods = [
    "shaken",
    "stirred",
    "boiled",
    "previously frozen",
    "reclaimed"
  ];
  List<String> _unitAdditionMethods = [
    "pour",
    "strain",
    "add",
    "drizzle",
    "perculate",
    "gargle it before spitting"
  ];

  bool ready() => this.isReady;

  int drinksGeneratedThisSession() => this._drinksGenerated;

  Future<bool> initWithFuture() {
    return Future.delayed(Duration(seconds: 0), () {
      this._ingredientController = Get.put(new IngredientController());
      this._settingsController = Get.put(new SettingsController());
      this._drinkController = Get.put(new DrinkController());
      this.isReady = true;
      return true;
    });
  }

  String generateTextForRecipe(Ingredient i, int index) {
    if (index == 0) {
      List<String> intro = [
        "Let's begin by",
        "Let's start by",
        "We'll begin by",
        "We'll start this recipe off by",
        "I'll need you to start by"
      ];
      intro.shuffle();
      _unitPreparationMethods.shuffle();
      return intro[0] +
          " " +
          _unitPreparationMethods[0] +
          " the " +
          i.name.toLowerCase() +
          ".";
    }
    if (index % 2 == 1) {
      _unitPrePreparationMethods.shuffle();
      _unitAdditionMethods.shuffle();
      return _unitPrePreparationMethods[0].capitalizeFirst +
          " the " +
          i.name.toLowerCase() +
          " and " +
          _unitAdditionMethods[0] +
          " it into your glass.";
    }
    _unitPostPreparationMethods.shuffle();
    _unitAdditionMethods.shuffle();
    return _unitAdditionMethods[0].capitalizeFirst +
        " the " +
        _unitPostPreparationMethods[0] +
        " " +
        i.name.toLowerCase() +
        " into your glass.";
  }

  String generateDrinkName() {
    _colors.shuffle();
    _places.shuffle();
    _nouns.shuffle();
    return "The " + _colors[0] + " " + _places[0] + " " + _nouns[0];
  }

  String generateDrinkNameWithIngredients(List<Ingredient> i) {
    i.shuffle();
    _colors.shuffle();
    return "The " + _colors[0] + " " + i[0].name;
  }

  Future<Drink> steal(http.Client client) {
    return Future.delayed(Duration(seconds: 2), () async {
      Drink d = new Drink();
      if (_ingredientController.getIngredients().length <= 0) {
        throw ("I'll need more ingredients to mix you a drink!");
      }
      GeneratorBehaviourType t = _settingsController.getActiveBehaviourType();
      var ui = <Ingredient>[];
      var pi = _ingredientController.getIngredients();
      switch (t) {
        // TODO
        case GeneratorBehaviourType.DEATH:
          var di = _ingredientController.searchMultipleByPercentage(60, 0);
          if (di.length > 5) {
            pi = di;
          }
          if (pi.length > 5) {
            pi.shuffle();
            for (int i = 0; i < 4; i++) {
              ui.add(pi[i]);
            }
          } else {
            for (int i = 0; i < pi.length; i++) {
              ui.add(pi[i]);
            }
          }
          break;
        case GeneratorBehaviourType.HUGO_ADVERT:
          Ingredient hugo = _ingredientController.searchByName("hugo");
          if (hugo == null) {
            throw ("Please add some Hugo");
          }
          ui.add(hugo);
          if (pi.length > 4) {
            pi.shuffle();
            for (int i = 0; i < 3; i++) {
              ui.add(pi[i]);
            }
          } else {
            for (int i = 0; i < pi.length; i++) {
              ui.add(pi[i]);
            }
          }
          break;
        case GeneratorBehaviourType.WATER_ONLY:
          Ingredient water = _ingredientController.searchByName("water");
          if (water == null) {
            throw ("Please add some water");
          }
          ui.add(water);
          if (pi.length > 4) {
            pi.shuffle();
            for (int i = 0; i < 3; i++) {
              ui.add(pi[i]);
            }
          } else {
            for (int i = 0; i < pi.length; i++) {
              ui.add(pi[i]);
            }
          }
          break;
        case GeneratorBehaviourType.NON_ALCOHOLIC:
          var na = _ingredientController.searchMultipleByPercentage(1, 0);
          if (na.length > 4) {
            pi.shuffle();
            for (int i = 0; i < 3; i++) {
              ui.add(na[i]);
            }
          } else {
            for (int i = 0; i < na.length; i++) {
              ui.add(na[i]);
            }
          }
          break;
        case GeneratorBehaviourType.UNDER_18:
          var na = _ingredientController.searchMultipleByPercentage(0, 0);
          if (na.length > 4) {
            pi.shuffle();
            for (int i = 0; i < 3; i++) {
              ui.add(na[i]);
            }
          } else {
            for (int i = 0; i < na.length; i++) {
              ui.add(na[i]);
            }
          }
          break;
        default:
          if (pi.length > 5) {
            pi.shuffle();
            for (int i = 0; i < 4; i++) {
              ui.add(pi[i]);
            }
          } else {
            for (int i = 0; i < pi.length; i++) {
              ui.add(pi[i]);
            }
          }
          break;
      }
      List<String> iNames = [];
      for (Ingredient i in ui) {
        iNames.add(i.name);
      }
      d.i = ui;
      d.name = generateDrinkNameWithIngredients(ui);
      d.percentage = 0; // TODO VERY BAD
      for (Ingredient z in d.i) {
        d.percentage = (d.percentage + z.percentage).toInt();
      }
      d.percentage = d.percentage ~/ d.i.length;
      RecipeGPTRequest r = new RecipeGPTRequest(
          direction: [], title: [d.name], ingredient: iNames, top_k: 0);
      // Send to kind people
      try {
        var result = await Requests.post("https://recipegpt.org/process",
            body: jsonEncode(r.toJson()),
            bodyEncoding: RequestBodyEncoding.JSON,
            headers: <String, String>{
              "User-Agent":
                  "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:85.0) Gecko/20100101 Firefox/85.0",
              "Accept": "application/json, text/javascript, */*; q=0.01",
              "Accept-Language": "en-US,en;q=0.5",
              "Content-Type": "application/json;charset=UTF-8",
              "X-Requested-With": "XMLHttpRequest",
              "Pragma": "no-cache",
              "Cache-Control": "no-cache",
              "Referrer": "https://recipegpt.org/"
            });

        if (result.statusCode == 200) {
          RecipeGPTResponse r2 = new RecipeGPTResponse.fromJson(result.json());
          d.recipe = r2.prompt;
          if (_settingsController.getActiveBehaviourType() ==
              GeneratorBehaviourType.WATER_ONLY) {
            d.recipe = d.recipe +
                "\n\n" +
                "PS: Don't forget to check if a jug is full of water by pouring it's contents onto a counter!";
          }
          //d.recipe = d.recipe + "\n\n" + _closingPhrases[0];
          // print(d.toJson().toString());
          _drinkController.addDrink(d);
          this._drinksGenerated = this._drinksGenerated + 1;
          client.close();
          return d;
        } else {
          print("Error chatting to RecipeGPT");
          print(result.statusCode);
          print(result.content());
          print(result.headers);
          throw ("Error chatting to RecipeGPT");
        }
      } catch (e) {
        print(e.toString());
        d = await this.generate();
        client.close();
        return d;
      }
    });
  }

  generate() {
    return Future.delayed(Duration(seconds: 5), () {
      GeneratorBehaviourType t = _settingsController.getActiveBehaviourType();
      Drink d = new Drink();
      int targetPercentage;
      int cupSizeMl = 330;
      int additiveUnit = 30; // ml, about one shot
      int currentDrinkAmount = 0;
      double currentPercentage = 0;
      if (_ingredientController.getIngredients().length <= 0) {
        throw ("I'll need more ingredients to mix you a drink!");
      }
      switch (t) {
        case GeneratorBehaviourType.HUGO_ADVERT:
          targetPercentage = 7;
          Ingredient hugo = _ingredientController.searchByName("hugo");
          if (hugo == null) {
            throw ("Please add some Hugo");
          }
          d.i.add(hugo);
          List<Ingredient> pI = _ingredientController
              .searchMultipleByPercentage(targetPercentage, 0);
          List<Ingredient> uI = <Ingredient>[];
          int j = 0;
          while (currentPercentage <= targetPercentage &&
              currentDrinkAmount <= cupSizeMl) {
            pI.shuffle();
            if (!uI.contains(pI[0])) {
              uI.add(pI[0]);
            }
            d.recipe = d.recipe + generateTextForRecipe(pI[0], j);
            j = j + 1;
            currentDrinkAmount = (j + 1) * additiveUnit;
            currentPercentage =
                currentPercentage + (additiveUnit * pI[0].percentage / 100);
          }
          d.i.addAll(uI);

          d.recipe = d.recipe +
              "Finally, if available, top this glass up with a bit of Hugo Rosé!";
          break;
        case GeneratorBehaviourType.NON_ALCOHOLIC:
          targetPercentage = 1;
          List<Ingredient> pI = _ingredientController
              .searchMultipleByPercentage(targetPercentage, 0);
          List<Ingredient> uI = <Ingredient>[];
          int j = 0;
          while (currentPercentage <= targetPercentage &&
              currentDrinkAmount <= cupSizeMl) {
            pI.shuffle();
            if (!uI.contains(pI[0])) {
              uI.add(pI[0]);
            }
            d.recipe = d.recipe + generateTextForRecipe(pI[0], j);
            j = j + 1;
            currentDrinkAmount = (j + 1) * additiveUnit;
            currentPercentage =
                currentPercentage + (additiveUnit * pI[0].percentage / 100);
          }
          d.i.addAll(uI);
          break;
        case GeneratorBehaviourType.DEATH:
          targetPercentage = 60;
          List<Ingredient> pI = _ingredientController
              .searchMultipleByPercentage(targetPercentage, 0);
          List<Ingredient> uI = <Ingredient>[];
          int j = 0;
          while (currentPercentage <= targetPercentage &&
              currentDrinkAmount <= cupSizeMl) {
            pI.shuffle();
            if (!uI.contains(pI[0])) {
              uI.add(pI[0]);
            }
            d.recipe = d.recipe + generateTextForRecipe(pI[0], j);
            j = j + 1;
            currentDrinkAmount = (j + 1) * additiveUnit;
            currentPercentage =
                currentPercentage + (additiveUnit * pI[0].percentage / 100);
          }
          d.i.addAll(uI);
          break;

        case GeneratorBehaviourType.UNDER_18:
          targetPercentage = 0;
          List<Ingredient> pI = _ingredientController
              .searchMultipleByPercentage(targetPercentage, 0);
          List<Ingredient> uI = <Ingredient>[];
          int j = 0;
          while (currentPercentage <= targetPercentage &&
              currentDrinkAmount <= cupSizeMl) {
            pI.shuffle();
            if (!uI.contains(pI[0])) {
              uI.add(pI[0]);
            }
            d.recipe = d.recipe + generateTextForRecipe(pI[0], j);
            j = j + 1;
            currentDrinkAmount = (j + 1) * additiveUnit;
            currentPercentage =
                currentPercentage + (additiveUnit * pI[0].percentage / 100);
          }
          d.i.addAll(uI);
          break;
        case GeneratorBehaviourType.WATER_ONLY:
          targetPercentage = 0;
          Ingredient water = _ingredientController.searchByName("wasser");
          if (water != null) {
            water = _ingredientController.searchByName("water");
          }
          if (water == null) {
            throw ("Please add some water");
          }
          d.i.add(water);
          int j = 0;
          while (currentPercentage <= targetPercentage &&
              currentDrinkAmount <= cupSizeMl) {
            d.recipe = d.recipe + generateTextForRecipe(water, j);
            j = j + 1;
            currentDrinkAmount = (j + 1) * additiveUnit;
            currentPercentage =
                currentPercentage + (additiveUnit * water.percentage / 100);
          }
          d.recipe = d.recipe +
              "\nFinally, pour about two liters of water into a jug and check to see if the jug is full by pouring the contents of the jug onto a counter!";
          break;
        default:
          targetPercentage = 20;
          List<Ingredient> pI = _ingredientController
              .searchMultipleByPercentage(targetPercentage, 0);
          List<Ingredient> uI = <Ingredient>[];
          int j = 0;
          while (currentPercentage <= targetPercentage &&
              currentDrinkAmount <= cupSizeMl) {
            pI.shuffle();
            if (!uI.contains(pI[0])) {
              uI.add(pI[0]);
            }
            d.recipe = d.recipe + generateTextForRecipe(pI[0], j);
            j = j + 1;
            currentDrinkAmount = (j + 1) * additiveUnit;
            currentPercentage =
                currentPercentage + (additiveUnit * pI[0].percentage / 100);
          }
          d.i.addAll(uI);
          break;
      }
      _closingPhrases.shuffle();
      d.recipe = d.recipe + "\n\n" + _closingPhrases[0];
      d.name = generateDrinkName();
      d.percentage = currentPercentage.toInt();
      _drinkController.addDrink(d);
      this._drinksGenerated = this._drinksGenerated + 1;
      return d;
    });
  }
}
