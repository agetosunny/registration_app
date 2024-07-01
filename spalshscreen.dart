import 'package:agelax/login.dart';
import 'package:flutter/material.dart';

class Spalshscreen extends StatefulWidget {
  const Spalshscreen({super.key});

  @override
  State<Spalshscreen> createState() => _SpalshscreenState();
}

class _SpalshscreenState extends State<Spalshscreen> {
  @override
  void initState() {
    super.initState();
    navigateTo();
  }

  void navigateTo() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Icon(
            Icons.deblur,
            color: Colors.white,
          ),
          title: Text(
            "loading.......",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            Icon(
              Icons.home,
              color: Colors.white,
            )
          ],
        ),
        body: Center(
          child: SizedBox(
            height: double.infinity,
            child: Image.asset("C:/FLUTTERprojects/agelax/assets/mainlogo.jpg"),
          ),
        ));
  }
}
