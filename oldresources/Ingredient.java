package mixer;

public class Ingredient {
	String name;
	int alc; // in percent 
	int amount; //in liters
	
	public Ingredient(String name, int alc, int amount) {
		this.name = name;
		this.alc = alc;
		this.amount= amount;
	}
	
	public Ingredient getIngredient() {
		return this;
	}
	
}
