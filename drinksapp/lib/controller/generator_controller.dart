import 'package:drinksapp/common/enums.dart';
import 'package:drinksapp/controller/ingredient_controller.dart';
import 'package:drinksapp/controller/settings_controller.dart';
import 'package:drinksapp/controller/drink_controller.dart';
import 'package:drinksapp/models/drink.dart';
import 'package:drinksapp/models/ingredient.dart';
import "package:get/get.dart";

class Generator {
  IngredientController _ingredientController;
  SettingsController _settingsController;
  DrinkController _drinkController;
  bool isReady = false;
  int _drinksGenerated = 0;
  List<String> _closingPhrases = [
    'Bon Appetit!',
    'Sauf mit Verantwortung!',
    'Enjoy responsibly!',
    "Don't puke on the carpet!",
    "Feel free to throw this one down the sink if no one's looking.",
    "Prost!",
    "Chin-Chin!",
    "здоровье! (Nastrovie!)",
    "Auf X!"
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
    Future.delayed(Duration(seconds: 0), () {
      this._ingredientController = Get.put(new IngredientController());
      this._settingsController = Get.put(new SettingsController());
      this._drinkController = Get.put(new DrinkController());
      this.isReady = true;
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
          i.name +
          ".";
    }
    if (index % 2 == 1) {
      _unitPrePreparationMethods.shuffle();
      _unitAdditionMethods.shuffle();
      return _unitPrePreparationMethods[0].capitalizeFirst +
          " the " +
          i.name +
          " and " +
          _unitAdditionMethods[0] +
          " it into your glass.";
    }
    _unitPostPreparationMethods.shuffle();
    _unitAdditionMethods.shuffle();
    return _unitAdditionMethods[0].capitalizeFirst +
        " the " +
        _unitPostPreparationMethods[0] +
        i.name;
  }

  generate() {
    return Future.delayed(Duration(seconds: 0), () {
      GeneratorBehaviourType t = _settingsController.getActiveBehaviourType();
      Drink d = new Drink();
      int targetPercentage;
      int cupSizeMl = 330;
      int additiveUnit = 30; // ml, about one shot
      int currentDrinkAmount = 0;
      bool failed = false;
      double currentPercentage = 0;
      if (_ingredientController.getIngredients().length <= 0) {
        failed = true;
        return failed;
      }
      switch (t) {
        case GeneratorBehaviourType.HUGO_ADVERT:
          targetPercentage = 7;
          Ingredient hugo = _ingredientController.searchByName("hugo");
          if (hugo == null) {
            failed = true;
            break;
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
            d.recipe = d.recipe + "\n" + generateTextForRecipe(pI[0], j);
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
            d.recipe = d.recipe + "\n" + generateTextForRecipe(pI[0], j);
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
            d.recipe = d.recipe + "\n" + generateTextForRecipe(pI[0], j);
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
            d.recipe = d.recipe + "\n" + generateTextForRecipe(pI[0], j);
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
            failed = true;
            break;
          }
          d.i.add(water);
          int j = 0;
          while (currentPercentage <= targetPercentage &&
              currentDrinkAmount <= cupSizeMl) {
            d.recipe = d.recipe + "\n" + generateTextForRecipe(water, j);
            j = j + 1;
            currentDrinkAmount = (j + 1) * additiveUnit;
            currentPercentage =
                currentPercentage + (additiveUnit * water.percentage / 100);
          }
          d.recipe = d.recipe +
              "\nFinally, pour about two liters of water into a jug and check to see if the jug is full by pouring the contents of the jug onto the floor.";
          break;
        default:
          targetPercentage = 20;
      }
      if (failed) {
        return failed;
      }
      _closingPhrases.shuffle();
      d.recipe = d.recipe + "\n\n" + _closingPhrases[0];
      d.recipe = d.recipe + _drinkController.addDrink(d);
      this._drinksGenerated = this._drinksGenerated + 1;
      return failed;
    });
  }
}
