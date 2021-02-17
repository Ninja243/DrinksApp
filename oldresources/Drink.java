package mixer;

import java.util.ArrayList;

public class Drink {
	public ArrayList<Ingredient> Ingredients = new ArrayList<>();
	public Drink() {
		
	}
	public void listIngredients() {
		for(int i = 0; i < this.Ingredients.size(); i++) {
			System.out.println(this.Ingredients.get(i).name + ",	" + this.Ingredients.get(i).amount + "Shots");
		}
	}
}
