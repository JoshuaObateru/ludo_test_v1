import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ludo_test/app/modules/ludo/data/models/token.dart';
import 'package:ludo_test/app/modules/ludo/views/ludo_view.dart';
import 'package:provider/provider.dart';

import '../../ludo/data/models/game_state.dart';

class SelectTokenView extends StatelessWidget {
  SelectTokenView({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> tokens = [
    {"type": TokenType.green, "color": Colors.green},
    {"type": TokenType.yellow, "color": Colors.yellow},
    {"type": TokenType.blue, "color": Colors.blue},
    {"type": TokenType.red, "color": Colors.red}
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final gameState = Provider.of<GameState>(context);
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Text(
              "Welcome",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.width * 0.06),
            ),
            const Text("Select a Dice to Continue"),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List<Widget>.generate(tokens.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        gameState.assignUserToToken(tokens[index]['type']);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(size.width)),
                        elevation: 3,
                        child: Container(
                          width: size.width * 0.12,
                          height: size.width * 0.12,
                          decoration: BoxDecoration(
                              color: tokens[index]['color'],
                              shape: BoxShape.circle),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.03,
                      height: size.height * 0.03,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, border: Border.all()),
                    )
                  ],
                );
              }),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
