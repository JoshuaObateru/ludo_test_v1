import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ludo_test/app/modules/ludo/data/models/game_state.dart';
import 'package:ludo_test/app/modules/ludo/dice.dart';
import 'package:ludo_test/app/modules/ludo/dice_turn_widget.dart';
import 'package:ludo_test/app/modules/ludo/views/board_view.dart';
import 'package:ludo_test/app/modules/ludo/views/game_play.dart';
import 'package:provider/provider.dart';

import '../../../services/firebase_firestore_service.dart';
import '../controllers/ludo_controller.dart';

class LudoView extends StatefulWidget {
  const LudoView({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _LudoViewState createState() => _LudoViewState();
}

class _LudoViewState extends State<LudoView> {
  GlobalKey keyBar = GlobalKey();
  void _onPressed() {}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final gameState = Provider.of<GameState>(context);
    return Scaffold(
      appBar: AppBar(
        key: keyBar,
        title: Text('Ludo'),
      ),
      body: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GamePlay(keyBar, gameState),
          Positioned(
            top: size.height * 0.05,
            left: 0,
            child: DiceTurnWidget(
              turn: 1,
              token: gameState.gameTokens![0],
              isTop: true,
            ),
          ),
          Positioned(
              top: size.height * 0.05,
              right: 0,
              child: DiceTurnWidget(
                isDiceLeading: true,
                turn: 2,
                isTop: true,
                token: gameState.gameTokens![4],
              )),
          Positioned(
              bottom: size.height * 0.05,
              right: 0,
              child: DiceTurnWidget(
                isDiceLeading: true,
                turn: 3,
                isTop: false,
                token: gameState.gameTokens![8],
              )),
          Positioned(
              bottom: size.height * 0.05,
              left: 0,
              child: DiceTurnWidget(
                turn: 4,
                isTop: false,
                token: gameState.gameTokens![12],
              )),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      // floatingActionButton: Dice(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Provider.of<GameState>(context, listen: false).socket.disconnect();
    GameState().onGameLogout();
    super.dispose();
  }
}

// 
