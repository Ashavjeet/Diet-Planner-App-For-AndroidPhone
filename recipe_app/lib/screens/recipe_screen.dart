// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, await_only_futures


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_app/screens/recipe_screen.dart';
import 'package:recipe_app/screens/search_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../model/meal_model.dart';
import '../model/meal_plan_model.dart';
import '../model/recipe_model.dart';
import '../services/api_services.dart';

class RecipeScreen extends StatefulWidget {
  //widget takes in String mealType and Recipe recipe
  final String mealType;
  final String recipe;
  final String name;

  RecipeScreen({this.mealType, this.recipe,this.name});
  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //Fav button
      floatingActionButton: (fav==true)?SizedBox():FloatingActionButton(
        child: Icon(Icons.favorite_outline),
        backgroundColor: Colors.orange,
        
        onPressed: ()async{
          User user=await FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance.collection("FavouriteRecipees").doc().set({
            "title":widget.name,
            "url":widget.recipe,
            "type":widget.mealType,
            "uid":user.uid
          });
          Fluttertoast.showToast(msg: "Added To Favourites");

        },
      ),
      appBar: AppBar(
        title: Text(widget.mealType),
      ),

      body: WebView(
        initialUrl: widget.recipe,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}