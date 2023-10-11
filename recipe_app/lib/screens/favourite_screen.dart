// ignore_for_file: unused_import, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screens/recipe_screen.dart';
import '../main.dart';
import '../model/recipe_model.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Favourite Meal Plan'),
          backgroundColor: Colors.orange,
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance//Opens cureent user details
              .collection("FavouriteRecipees")
              .where('uid', isEqualTo: uId)
              .snapshots(),

          //calls buildMealCard with data
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        return GestureDetector(
                            onTap: () {
                            },
                            onLongPress: () {},
                            child: _buildMealCard(index - 1, data));
                      },
                    ),
                  );
          },
        ));
  }

  _buildMealCard(int index, data) {
    return GestureDetector(
      /*Button uses recId and goes fetchRecipe method.
        Open recipee screen with data*/
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RecipeScreen(
                      mealType: data['type'],
                      recipe: data['url'],
                      name: data['title'],
                    )));
                  },
          //UI
      child: Stack(alignment: Alignment.center, children: <Widget>[
        //First widget is a container that loads decoration image
        Container(
          height: 220,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 2), blurRadius: 6)
              ]),
        ),
        
        //UI
        Container(
          margin: EdgeInsets.all(60),
          padding: EdgeInsets.all(10),
          color: Colors.white70,
          child: Column(
            children: <Widget>[
              Text(
                //mealtype
                data['type'],
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5),
              ),
              Text(
                //mealtitle
                data['title'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
      ]),
    );
  }
}
