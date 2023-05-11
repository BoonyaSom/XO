import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:xo/page/lounge.dart';
import 'package:xo/page/scoreboard.dart';
import 'package:xo/widgets/custom_textfield.dart';
import 'package:xo/widgets/custome_text.dart';
//import 'package:xo/provider/room_data_provider.dart';

import 'package:xo/widgets/custom_buttom.dart';

class CreateRoom extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final nameController = TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('games');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomText(text: 'Create Room !', fontSize: 50),
              SizedBox(height: size.height * 0.05),
              CustomeTextField(
                controller: nameController,
                hintText: 'Enter your Name',
              ),
              SizedBox(height: size.height * 0.01),
              CustomButton(
                  onTap: () {
                    if (nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Name cannot be blank'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      Map<String, dynamic> room = {
                        'user1': nameController.text,
                        'user2': 'non',
                        'counter':
                            1 // add a counter field and set its value to 1
                      };
                      dbRef.push().set(room);
                      final newPostKey = dbRef.push().key.toString(); //get key
                      print(newPostKey); //show the key in console
                      nameController.clear();
                      Navigator.pushNamed(context, Lounge.routeName,
                          arguments: newPostKey);
                    }
                  },
                  text: 'Create')
            ],
          ),
        ));
  }
}
