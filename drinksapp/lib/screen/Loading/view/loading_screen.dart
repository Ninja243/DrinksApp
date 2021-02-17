import 'package:drinksapp/screen/Home/view/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Home()//Lottie.asset(
          //"assets/swimming-killer-whale.json",
          //width: 210,
          //height: 210,
          //fit: BoxFit.cover,
          //repeat: true,
          //),
          ),
    );
  }
}
