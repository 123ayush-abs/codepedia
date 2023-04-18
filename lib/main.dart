import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './constant.dart';
import 'package:avatar_glow/avatar_glow.dart';
import './contestdetails.dart';
import './splash.dart';

void main() => runApp(
      MaterialApp(
        home: SplashScreen(),
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
      ),
    );
Color customwhite = const Color.fromARGB(255, 237, 237, 237);

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontFamily: "fnn",
                    fontSize: 25,
                    color: Colors.redAccent,
                    height: 2,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "To",
                  style: TextStyle(
                    fontFamily: "fnn",
                    fontSize: 15,
                    color: Colors.black,
                    height: 2,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "CodePedia!!",
                  style: TextStyle(
                    fontFamily: "fnn",
                    fontSize: 30,
                    color: Colors.indigo,
                    height: 2,
                  ),
                ),
               
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Apii()));
        },
        //Navigator.of(context).push(route)
        child: Icon(
          Icons.forward,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
