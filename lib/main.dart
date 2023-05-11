import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xo/firebase_options.dart';
import 'package:xo/page/displayScore.dart';
import 'package:xo/page/scoreboard.dart';
import 'package:xo/page/welcome_page.dart';
import 'package:xo/page/create_page.dart';
import 'package:xo/page/join_page.dart';
import 'package:xo/page/lounge.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1)),
      onGenerateRoute: (settings) {
        /*if (settings.name == Scoreboard.routeName) {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) => Scoreboard(
              //roomID: args['roomID']!,
              //playerName: args['playerNameX']!,
              //playerNameX: args['playerNameX']!,
              //playerNameY: args['playerNameY']!,
            ),
          );
        }
        return null;*/
      },
      routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        CreateRoom.routeName: (context) => const CreateRoom(),
        JoinRoom.routeName: (context) => const JoinRoom(),
        Lounge.routeName: (context) => const Lounge(),
        Scoreboard.routeName: (context) => const Scoreboard(),
        displayScore.routeName: (context) => const displayScore(),
      },
      initialRoute: WelcomePage.routeName,
    );
  }
}
