import 'package:get/get.dart';
import 'package:drinksapp/models/ingredient.dart';

class IngredientController extends GetxController {
  RxList<Ingredient> _ingredients = <Ingredient>[].obs;

  List<Ingredient> getIngredients() => _ingredients;

  Ingredient getIngredient(int index) => _ingredients[index];

  setIngredients(List<Ingredient> i) {
    this._ingredients.assignAll(i);
  }

  addIngredient(Ingredient i) {
    this._ingredients.add(i);
  }

  deleteIngredientFromIndex(int index) {
    this._ingredients.removeAt(index);
  }

  deleteIngredient(Ingredient ingredient) {
    this._ingredients.removeWhere((item) => ingredient == item);
  }
}
