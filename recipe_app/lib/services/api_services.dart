//This file will handle all our API calls to the 
//Spoonacular API
// ignore_for_file: avoid_print, constant_identifier_names


import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/meal_plan_model.dart';
import '../model/recipe_model.dart';

class ApiService {
  ApiService._instantiate();
  static final ApiService instance = ApiService._instantiate();
  final String _baseURL = "api.spoonacular.com";
  static const String API_KEY ="adfb96fedaea4eb9a76cfc1e733d0899";


   //https://api.spoonacular.com/mealplanner/generate?targetCalories=2500&timeFrame=day&apiKey=adfb96fedaea4eb9a76cfc1e733d0899&diet=Vegan
  
  Future<MealPlan> generateMealPlan({int targetCalories, String diet}) async {
    //check if diet is null
    if (diet == 'None') diet = '';
    Map<String, dynamic> parameters = {
      'timeFrame': 'day', //to get 3 meals
      "targetCalories":targetCalories.toString(),
      'diet': diet,
      "apiKey":API_KEY
    };
    //The Uri consists of the base url, the endpoint we are going to use. It has also 
    //parameters
    Uri uri = Uri.https(
      _baseURL,
      '/mealplanner/generate',
      parameters,
    );
    //Our header specifies that we want the request to return a json object
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    //decodes the body of the response into a map, and converts the map into a mealPlan
    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);//decode the body of the response into a map
      
      //MealPlan.fromMap convert
      MealPlan mealPlan = MealPlan.fromMap(data);
      return mealPlan;

    } catch (err) {
      //If response has error
      throw err.toString();
    }
  }



  //fetchRecipe using id
  Future<Recipe> fetchRecipe(String id) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': API_KEY,
    };

    //call in the recipe id in the Uri
    Uri uri = Uri.https(
      _baseURL,
      '/recipes/$id/information',
      parameters,
    );

    //And also specify that we want our header to return a json object
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try{
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      Recipe recipe = Recipe.fromMap(data);
      return recipe;

    }
    catch (error) {
      throw error.toString();
    }

  }

}