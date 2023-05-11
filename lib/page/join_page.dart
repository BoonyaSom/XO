import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xo/page/scoreboard.dart';
import 'package:xo/widgets/custom_textfield.dart';
import 'package:xo/widgets/custome_text.dart';
import 'package:xo/widgets/custom_buttom.dart';

class JoinRoom extends StatefulWidget {
  static const String routeName = '/join-room';
  const JoinRoom({Key? key}) : super(key: key);

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final TextEditingController _nameController = TextEditingController();
  late DatabaseReference dbRef;
  final String fixedRoomID = 'room1'; // Fixed room ID for all players

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('room');
  }

  Future<void> _joinRoom(BuildContext context) async {
    final String playerNameX = _nameController.text.trim();
    String playerNameY = ''; // Initialize playerNameY to an empty string
    final String roomID = "room"; // Replace with your standard room ID
    if (playerNameX.isNotEmpty) {
      final DatabaseEvent event =
          await dbRef.child('games').child(roomID).once();
      final Map<dynamic, dynamic>? value =
          event.snapshot.value as Map<dynamic, dynamic>?;
      final int counter = value?['counter'] ?? 0;
      if (counter % 2 == 0) {
        // Add user X to the room
        await dbRef
            .child('games')
            .child(roomID)
            .update({'user1': playerNameX, 'counter': counter + 1});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Waiting for another player to join...'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Add user Y to the room
        await dbRef
            .child('games')
            .child(roomID)
            .update({'user2': playerNameX, 'counter': counter + 1});
        playerNameY = value!['user1'] ??
            ''; // Set playerNameY to the name of the first player, or to an empty string if not available

        // Navigate to game screen
        Navigator.pushNamed(
          context,
          Scoreboard.routeName,
          arguments: {
            'roomID': roomID,
            'playerNameX': value!['user1'] ?? '',
            'playerNameY': playerNameX,
          },
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Player Name cannot be blank'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
            const CustomText(text: 'Join Game !', fontSize: 50),
            SizedBox(height: size.height * 0.05),
            CustomeTextField(
              controller: _nameController,
              hintText: 'Enter your Name',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () {
                final String playerName = _nameController.text.trim();
                if (playerName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Player Name cannot be blank'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  _joinRoom(context);
                  _nameController.clear();
                }
              },
              text: 'Join Game',
            )
          ],
        ),
      ),
    );
  }
}