import 'package:flutter/material.dart';
import 'package:ludo_test/app/modules/ludo/data/models/dice_model.dart';
import 'package:ludo_test/app/modules/ludo/data/models/game_state.dart';
import 'package:provider/provider.dart';

class Dice extends StatelessWidget {
  Future<void> updateDices(DiceModel dice, GameState gameState) async {
    for (int i = 0; i < 6; i++) {
      var duration = 100 + i * 100;
      var future = Future.delayed(Duration(milliseconds: duration), () {
        dice.generateDiceOne();
        gameState.dicerollSocket(dice);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> _diceOneImages = [
      "assets/1.png",
      "assets/2.png",
      "assets/3.png",
      "assets/4.png",
      "assets/5.png",
      "assets/6.png",
    ];
    final dice = Provider.of<DiceModel>(context);
    final gameState = Provider.of<GameState>(context);
    final c = dice.diceOneCount;
    var img = Image.asset(
      _diceOneImages[c - 1],
      gaplessPlayback: true,
      fit: BoxFit.fill,
    );
    return Card(
      elevation: 10,
      child: Container(
        height: 40,
        width: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (gameState.userModel?.turn == gameState.currentTurn) {
                        await updateDices(dice, gameState);

                        var future =
                            Future.delayed(const Duration(seconds: 1), () {
                          gameState.checkShouldPlay(dice.diceOne);
                          print("ShouldPlayy 2 ${gameState.shouldPlay}");
                          if (gameState.shouldPlay == false) {
                            gameState.updateGameTurn(dice.diceOne);

                            print("c $c");
                            print("diceoneee ${dice.diceOne}");
                          }
                        });
                      }

                      // gameState.updateGameTurn(dice.diceOne);

                      // print("c $c");
                      // print("diceoneee ${dice.diceOne}");
                    },
                    child: img,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
