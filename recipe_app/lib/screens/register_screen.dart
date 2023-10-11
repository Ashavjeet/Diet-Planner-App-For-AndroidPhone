// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, unnecessary_new, use_key_in_widget_constructors, avoid_print, await_only_futures


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screens/search_screen.dart';

import '../main.dart';
class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();
  TextEditingController name=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height*0.1,),

          Center(child: Text("Register",style: TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold,letterSpacing: 2.0),)),
          SizedBox(height: size.height*0.05,),
          fieldsCustom(size, "Name",name),
          SizedBox(height: 10.0,),
          fieldsCustom(size, "Email",email),
          SizedBox(height: 10.0,),
          fieldsCustom(size, "Password", pass),
          SizedBox(height: size.height*0.05,),

          InkWell(
              onTap: ()async{
                await signUp();
              },
              child: button("Register", Colors.orange, size, Colors.white))

        ],
      ),
    );
  }


  Future signUp()async{
    var emaill = email.text;
    var password = pass.text;
    var namme=name.text;

    FirebaseAuth _auth=FirebaseAuth.instance;
    final User user = await _auth.currentUser;
    uId=user.uid;
    setState(() {

    });
    // final userid = user.uid;
    _auth
        .createUserWithEmailAndPassword(
        email: emaill, password: password)
        .then((value) {
      FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'email': emaill,
        'name': namme,
        'uid':user.uid,
      }).then((value) {

        if (user != null) {
          Navigator
              .of(context)
              .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
            return SearchScreen();

          }));        }
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });

  }

  Widget fieldsCustom(size,hint,controller){
    return Container(

      width: size.width*0.8,
      height:size.height*0.065,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.0,
                offset: Offset(0,0)
            ),
          ],
          borderRadius: BorderRadius.circular(20.0),
          color: Color.fromRGBO(245, 245, 245, 1)
      ),
      child: Padding(
          padding:  EdgeInsets.only(left:78.0),
          child:TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "$hint",
              hintStyle: TextStyle(color:Color.fromRGBO(196, 196, 196, 1) ),
              border: OutlineInputBorder(),
              enabledBorder: InputBorder.none,
            ),
          )
      ),
    );
  }
  Widget button(name,color,size,colortxt){
    return Container(

      width: size.width*0.8,
      height:size.height*0.065,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 0.0,
                offset: Offset(0,0)
            ),
          ],
          borderRadius: BorderRadius.circular(60.0),
          color: color
      ),
      child: Center(child: Text("$name",style: TextStyle(color: colortxt,fontSize: 22.0,fontWeight: FontWeight.bold,letterSpacing: 2.0),)),
    );
  }

}
