import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ludo_test/app/modules/ludo/data/models/dice_model.dart';
import 'package:ludo_test/app/modules/ludo/data/models/token.dart';
import 'package:ludo_test/app/modules/ludo/views/ludo_view.dart';
import 'package:provider/provider.dart';

import '../../ludo/data/models/game_state.dart';

class SelectTokenView extends StatefulWidget {
  SelectTokenView({Key? key}) : super(key: key);

  @override
  State<SelectTokenView> createState() => _SelectTokenViewState();
}

class _SelectTokenViewState extends State<SelectTokenView> {
  final List<Map<String, dynamic>> tokens = [
    {"type": TokenType.green, "color": Colors.green},
    {"type": TokenType.yellow, "color": Colors.yellow},
    {"type": TokenType.blue, "color": Colors.blue},
    {"type": TokenType.red, "color": Colors.red}
  ];

  TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final gameState = Provider.of<GameState>(context);
    final dice = Provider.of<DiceModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size.width * 0.06),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(
                    width: size.width * 0.5,
                    child: const Text(
                      "Enter Your Name and Select a Dice to Continue",
                      textAlign: TextAlign.center,
                    )),
                const Spacer(),
                TextFormField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                      hintText: 'Enter Your Name', label: Text('Name')),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your name';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List<Widget>.generate(tokens.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            gameState.assignUserToToken(tokens[index]['type'],
                                dice, textEditingController.text.trim());
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.width)),
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
        ),
      ),
    );
  }
}
