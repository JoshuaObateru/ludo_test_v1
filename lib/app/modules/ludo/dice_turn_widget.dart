import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'data/models/game_state.dart';
import 'dice.dart';

class DiceTurnWidget extends StatelessWidget {
  const DiceTurnWidget(
      {Key? key,
      this.isDiceLeading = false,
      required this.turn,
      this.color,
      this.foregroundColor})
      : super(key: key);

  final bool isDiceLeading;
  final int turn;
  final Color? color;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Card(
          elevation: 3,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            color: color ?? Colors.white,
            child: isDiceLeading == true
                ? Row(
                    children: [
                      AnimatedPadding(
                        duration: Duration(milliseconds: 100),
                        padding: const EdgeInsets.all(8.0),
                        child: gameState.currentTurn == turn
                            ? Dice()
                            : Container(
                                width: size.width * 0.1,
                                height: size.height * 0.05,
                                color: Colors.grey,
                              ),
                      ),
                      AnimatedPadding(
                        duration: Duration(milliseconds: 100),
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "$turn",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: foregroundColor ?? Colors.black,
                              fontSize: size.width * 0.05),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      AnimatedPadding(
                        duration: Duration(milliseconds: 100),
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "$turn",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: foregroundColor ?? Colors.black,
                              fontSize: size.width * 0.05),
                        ),
                      ),
                      AnimatedPadding(
                        duration: Duration(milliseconds: 100),
                        padding: const EdgeInsets.all(8.0),
                        child: gameState.currentTurn == turn
                            ? Dice()
                            : Container(
                                width: size.width * 0.1,
                                height: size.height * 0.05,
                                color: Colors.grey,
                              ),
                      )
                    ],
                  ),
          ),
        )
      ],
    );
  }
}
