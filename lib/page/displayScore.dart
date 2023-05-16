import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:xo/page/welcome_page.dart';
import 'package:xo/widgets/custom_buttom.dart';

class displayScore extends StatefulWidget {
  static String routeName = '/displayScore';
  const displayScore({super.key});

  @override
  State<displayScore> createState() => _displayScoreState();
}

class _displayScoreState extends State<displayScore> {
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('score');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: Image.asset(
              'assets/image/logo.png',
              scale: 4,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        ),
        body: Column(
          children: [
            Expanded(
                child: FirebaseAnimatedList(
                    query: dbRef,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map scoreMap = snapshot.value as Map;
                      return display(scoreMap: scoreMap);
                    })),
            CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, WelcomePage.routeName);
                },
                text: 'Home')
          ],
        ));
  }

  Widget display({required Map scoreMap}) {
    return Column(
      children: [
        displayX(scoreMap: scoreMap),
        displayO(scoreMap: scoreMap),
      ],
    );
  }

  Widget displayX({required Map scoreMap}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        color: const Color.fromRGBO(65, 65, 65, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              scoreMap['playerX'],
              style: TextStyle(fontSize: 20.0),
            ),
            Text(" : "),
            Text(
              scoreMap['scoreX'].toString(),
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayO({required Map scoreMap}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        color: const Color.fromRGBO(65, 65, 65, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              scoreMap['playerO'],
              style: TextStyle(fontSize: 20.0),
            ),
            Text(" : "),
            Text(
              scoreMap['scoreO'].toString(),
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
