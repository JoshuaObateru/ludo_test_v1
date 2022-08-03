import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ludo_test/app/modules/ludo/data/models/dice_model.dart';
import 'package:ludo_test/app/modules/ludo/data/models/game_state.dart';
import 'package:ludo_test/app/modules/ludo/views/ludo_view.dart';
import 'package:provider/provider.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // <--------------Firebase--------------->

  //create a nullable model/object of user
  // add user and make it nullable in token model
  //user in the token is null until a user selects that token at the beginning
  //check if current signed in user is the same with the user in the token in the move player method
  //check for how to use provider well with firebase
  //check for how to upload to firebase using models
  //stream or listen
  //update firebase turn in the update turn method

  // <--------------Firebase--------------->

  //dice should move only after player has played
  //if initial, and a 6 is not rolled, it can move before player played
  //pick a dice number at the beginning of the game
  //Create an array of turns or an int called current turn
  // Loop through the turns and come back to the start when it gets to the last turn
  //display the dice in a seperate box based on the position of the turn in the array
  //only if your dice number matches the turn number in the array then you can play(Roll the dice)
  //only if your dice number matches the turn number in the array then you can play(Move your token)
  //after move is completed, move to the next item in the turn array
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      title: "Application",
      // initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => GameState()),
        ChangeNotifierProvider(create: (context) => DiceModel()),
      ], child: LudoView(title: 'Flutter Demo Home Page')),
    ),
  );
}
