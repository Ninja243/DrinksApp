import 'package:get/get.dart';
import 'package:drinksapp/models/ingredient.dart';

class IngredientController extends GetxController {
  RxList<Ingredient> _ingredients = <Ingredient>[].obs;

  List<Ingredient> getIngredients() => _ingredients;

  Ingredient getIngredient(int i) => _ingredients[i];

  setIngredients(List<Ingredient> i) {
    this._ingredients.assignAll(i);
  }

  addIngredient(Ingredient i) {
    this._ingredients.add(i);
  }
}
