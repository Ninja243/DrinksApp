package mixer;

import java.util.ArrayList;


public class Mixer {
ArrayList<Ingredient> allIngredients = new ArrayList<>();
ArrayList<Ingredient> highIngredients = new ArrayList<>();
ArrayList<Ingredient> lowIngredients = new ArrayList<>();
ArrayList<Ingredient> zeroIngredients = new ArrayList<>();

ArrayList<Drink> generatedDrinks = new ArrayList<>();

	public Mixer() {
		
	}

	public void addIngredient(String name, int alc, int amountAvailable) {
		allIngredients.add(new Ingredient(name,alc,amountAvailable));
		if(alc > 12)
			highIngredients.add(new Ingredient(name,alc,amountAvailable));
		else if (alc > 0)
			lowIngredients.add(new Ingredient(name,alc,amountAvailable));
		else 
			zeroIngredients.add(new Ingredient(name,alc,amountAvailable));


	}
	
	//TODO Better drink generation: Generate (random) amount of (random) ingredients from each list, and then assign amounts accordingly
	
	public Drink generateDrink() {
		Drink inMixer = new Drink();
		for(int i = 0; i < (int)(Math.random() * 4 + 3); i++){
		inMixer.Ingredients.add(getRandomIngredient());
		}
		removeDuplicateIngredients(inMixer);
		fillDrink(inMixer);
		generatedDrinks.add(inMixer);
		inMixer.listIngredients();
		return inMixer;
	}
	
	public Ingredient getRandomIngredient() {
		return allIngredients.get((int)(Math.random() * (double)allIngredients.size()));
	}
	
	public Ingredient makeAmount() {
		Ingredient generated = new Ingredient(null, 0,0);
		generated = getRandomIngredient();
		generated.amount = (int)(Math.random() * 5 + 2 * Math.random() * 3);
		return generated;
		
	}
	
	public void removeDuplicateIngredients(Drink drink){
		int reduce = 0;
		//for(Ingredient ingredient : drink.Ingredients) {
		for (int i = 0; i < drink.Ingredients.size() - reduce - 1; i++) {
			for(int j = i + 1; j < drink.Ingredients.size() - reduce; j++) {
				if(drink.Ingredients.get(i) == drink.Ingredients.get(j)) {
					drink.Ingredients.remove(j);
					reduce++;
				}
			}
		}
	}
	
	public void fillDrink(Drink drink) {
		for (Ingredient ing : drink.Ingredients) {
			if(ing.alc > 10) {
				ing.amount = (int) Math.random() * 4 + 1;
			}
			else if (ing.alc >= 5) {
				ing.amount = (int) Math.random() * 6 + 1;
			}
			else ing.amount = (int) Math.random()* 6 + 3;
		}
	}
	
	//-------------------------- ALTERNATE DRINK GEN ----------------------------------------
	
	public Drink makeMeADrink() {
		Drink hereYaGo = new Drink();
		//add 0 to 2 high alcohol ingredients
		for(int i = 0; i <(int) Math.random() * 3; i++) {
			hereYaGo.Ingredients.add(getRandomIngredientFrom(highIngredients));
		}
		//add 1 to 3 low alcohol ingredients
		for(int i = 0; i <(int) Math.random() * 3 + 1; i++) {
			hereYaGo.Ingredients.add(getRandomIngredientFrom(lowIngredients));
		}
		
		//add 1 to 2 zero alcohol ingredients
		for(int i = 0; i <(int) Math.random() * 3 + 1; i++) {
			hereYaGo.Ingredients.add(getRandomIngredientFrom(zeroIngredients));
		}
		return hereYaGo;
	}
	
	public void fillItUp(Drink drink) {
		for(Ingredient i : drink.Ingredients) {
			i.amount = (int) Math.random()* 5 + 1;
		}
	}
	
	public void removeDupesFromDrink(Drink drink) {
		for(int i = 0; i < drink.Ingredients.size(); i++) {
			if(drink.Ingredients.size() - i < 1)
				return;
			for(int j = 0; j < drink.Ingredients.size(); j++) {
				if(drink.Ingredients.get(i) == drink.Ingredients.get(j)) {
					drink.Ingredients.remove(j);
				}
			}
		}
		
	}
	
	public Ingredient getRandomIngredientFrom(ArrayList<Ingredient> ingredList) {
		return ingredList.get((int)(Math.random() * (double)allIngredients.size()));
	}
	public void fillIngredients() {
		addIngredient("Vodka", 30, 0);
		addIngredient("Orange", 0, 0);
		addIngredient("Bier", 5, 0);
		addIngredient("Hugo", 6, 0);
		addIngredient("Spiritus", 90, 0);
		addIngredient( "marakuja", 0, 0);
		addIngredient( "apfel", 0, 0);
		addIngredient( "minuspol", 20, 0);
		addIngredient( "milch", 0, 0);
		addIngredient( "ananas", 0, 0);
		addIngredient( "rum", 25, 0);

		
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Mixer bruh = new Mixer();
		bruh.fillIngredients();
		//bruh.generateDrink();
		
		Drink one = bruh.makeMeADrink();
		bruh.removeDupesFromDrink(one);
		bruh.fillItUp(one);
		one.listIngredients();
		
	}
	
}
