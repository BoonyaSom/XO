import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:xo/page/join_page.dart';
import 'package:xo/page/scoreboard.dart';
import 'package:xo/widgets/custom_buttom.dart';
import 'package:xo/widgets/custome_text.dart';
import 'package:xo/widgets/custom_textfield.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
//import 'package:xo/provider/room_data_provider.dart';

class Lounge extends StatefulWidget {
  static String routeName = '/lounge';
  const Lounge({Key? key}) : super(key: key);

  @override
  State<Lounge> createState() => _LoungeState();
}

class _LoungeState extends State<Lounge> {
  late DatabaseReference dbRef;
  int? counter;

 

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('room').child('games');
    dbRef.child('room').child('counter').onValue.listen((event) {
      var snapshot = event.snapshot;
      if(snapshot.value != null){
        setState(() {
          counter = event.snapshot.value as int?;
          print("current: $counter");
            if(counter == 2){
              //route to the scoreboard.dart
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('someone has join the room!'),
                duration: Duration(seconds: 45),)
              ); /*FirebaseAnimatedList(
  query: dbRef.child('room'),
  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
    Map dataMap = snapshot.value as Map;
    return ListTile(
      title: Text(dataMap['title']),
      subtitle: Text(dataMap['subtitle']),
      // add more widgets to display other data as needed
    );
  },
);*/
          }
        });
      }
      
      
    });
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
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CustomText(text: 'wait for other to join...', fontSize: 20),
              //CustomText(text: 'current player in the room ${counter.toString()}', fontSize: 15),
            ],
          ),
        ));
  }
}