// ignore_for_file: unnecessary_new, avoid_print, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_catch_clause, await_only_futures, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/main.dart';
import 'package:recipe_app/screens/register_screen.dart';
import 'package:recipe_app/screens/search_screen.dart';

class SiginScreen extends StatefulWidget
{
  @override
  State<SiginScreen> createState() => _SiginScreenState();
}

class _SiginScreenState extends State<SiginScreen>
{
  TextEditingController email=TextEditingController();
  TextEditingController pass=TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SizedBox(height: size.height*0.1,),
          Center(child: Text("Login",style: TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold,letterSpacing: 2.0),)),
          SizedBox(height: size.height*0.05,),
          
          fieldsCustom(size, "Email",email),
          SizedBox(height: 10.0,),

          fieldsCustom(size, "Password",pass),
          SizedBox(height: size.height*0.05,),

          InkWell(
              onTap: ()async{
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email.text.trim(), password: pass.text.trim()).then((value) async {
                    final User currentUser = await FirebaseAuth.instance.currentUser;

uId=currentUser.uid;
setState(() {});

                    Navigator
                        .of(context)
                        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
                      return SearchScreen();
                    }));
                  });
                } on PlatformException catch (e) {
                  //   e.message;
                } catch (e) {
                  print(e);
                }
              },
              child: button("Sign in",Colors.orange, size, Colors.white)),
          SizedBox(height: 20.0),
          
          //Register button
          InkWell(
              onTap: ()async{

                    Navigator
                        .of(context)
                        .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) {
                      return RegisterScreen();

                    }));



              },
              child: button("Register", Colors.orange, size, Colors.white))

        ],
      ),
    );
  }

  //UI
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
