import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
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
  late String roomId;
  late int counter;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('games');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      roomId = args as String;
    }

    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: Image.asset(
              'image/logo.png',
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
            ],
          ),
        ));
  }
}