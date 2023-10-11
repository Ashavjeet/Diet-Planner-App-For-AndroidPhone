// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_print


import 'package:flutter/material.dart';
import 'package:recipe_app/screens/recipe_screen.dart';

import '../model/meal_model.dart';
import '../model/meal_plan_model.dart';
import '../model/recipe_model.dart';
import '../services/api_services.dart';

class MealsScreen extends StatefulWidget {
    final MealPlan mealPlan;
  MealsScreen({this.mealPlan});

  @override
  _MealsScreenState createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {

/*Curved edges and a BoxShadow, child is a column widget(nutrient info rows)*/

_buildTotalNutrientsCard() {
    return Container(
      height: 140,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Total Nutrients',//Heading
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Calories: ${widget.mealPlan.calories.toString()} cal',//Nutrient 1
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Protein: ${widget.mealPlan.protein.toString()} g',//Nutrient 2
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Fat: ${widget.mealPlan.fat.toString()} g',//Nutrient 3
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Carb: ${widget.mealPlan.carbs.toString()} cal',//Nutrient 4
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  _buildMealCard(Meal meal, int index) {
    String mealType = _mealType(index);
    return GestureDetector(

      /*
      The async onTap function will fetch the recipe by id using the fetchRecipe method.
      It will then navigate to RecipeScreen, while parsing in our mealType and recipe
       */
      onTap: () async {
        print(meal.imgURL);
        Recipe recipe =
            await ApiService.instance.fetchRecipe(meal.id.toString());
        Navigator.push(context,
        MaterialPageRoute(builder:  (_) => RecipeScreen(
          mealType: mealType,
          recipe: meal.imgURL,
          name: meal.title,
        )));
      },

      //UI
          child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            //First widget is a container that loads decoration image
            Container(
              height: 220,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(meal.imgURL),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
                  ]),
            ),


            //Container for meal type and name 
            Container(
              margin: EdgeInsets.all(60),
              padding: EdgeInsets.all(10),
              color: Colors.white70,
              child: Column(
                children: <Widget>[
                  Text(
                    mealType,style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5
                    ),
                  ),
                  Text(
                    meal.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ]
),
    );
}

/*mealType returns Breakfast, Lunch or Dinner, depending on the index value*/

_mealType(int index) {
    switch (index) {
      case 0:
        return 'Breakfast';
      case 1:
        return 'Lunch';
      case 2:
        return 'Dinner';
      default:
        return 'Breakfast';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Meal Plan'),backgroundColor: Colors.orange,automaticallyImplyLeading: false,),
            //List
            body: ListView.builder(
            //Lecture udm 164 API call based item count should be 1 + no of meals
           itemCount: 1 + widget.mealPlan.meals.length,
           itemBuilder: (BuildContext context, int index) {

            if (index == 0) {
              return _buildTotalNutrientsCard();
            }
            /*
            Otherwise, return a buildMealCard method that takes in the meal,
            and index - 1
            */
            Meal meal = widget.mealPlan.meals[index - 1];
            return _buildMealCard(meal, index - 1);
          }),
    );
  }
 }

