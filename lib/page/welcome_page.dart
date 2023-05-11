import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:xo/page/create_page.dart';
import 'package:xo/page/displayScore.dart';
import 'package:xo/page/join_page.dart';
import 'package:xo/widgets/custom_buttom.dart';

class WelcomePage extends StatelessWidget {
  static String routeName = '/welcome_page';
  const WelcomePage({Key? key}) : super(key: key);

  void create(BuildContext context) {
    Navigator.pushNamed(context, CreateRoom.routeName); //route to create room
  }

  void join(BuildContext context) {
    Navigator.pushNamed(context, JoinRoom.routeName); //route to join room
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('image/logo.png'),
          CustomButton(
            onTap: () => create(context),
            text: 'Create Room',
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
            onTap: () => join(context),
            text: 'Join Room',
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              onTap: () {
                Navigator.pushNamed(context, displayScore.routeName);
              },
              text: 'Scoreboard')
        ],
      ),
    );
  }
}
