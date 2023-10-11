// ignore_for_file: avoid_print

import 'meal_model.dart';

class MealPlan {
  //list of meals and nutritional info
  final List<Meal> meals;
  final double calories, carbs, fat, protein;
  MealPlan({this.meals, this.calories, this.carbs, this.fat, this.protein});


/*
The factory constructor decoddes data and creates a list of meals.
Returns MealPlan object with all the information 
*/


  factory MealPlan.fromMap(Map<String, dynamic> map) {
    List<Meal> meals = []; //Created new list
    print("ye h idr ");
    map['meals'].forEach(
        (mealMap) => meals.add(Meal.fromMap(mealMap))); //Convert Json L45
    print(meals);


    //MealPlan object data
    return MealPlan(
      meals: meals,
      calories: map['nutrients']['calories'],
      carbs: map['nutrients']['carbohydrates'],
      fat: map['nutrients']['fat'],
      protein: map['nutrients']['protein'],
    );
  }
}
