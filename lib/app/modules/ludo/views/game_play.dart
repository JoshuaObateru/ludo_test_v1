import 'package:flutter/material.dart';
import 'package:ludo_test/app/modules/ludo/data/models/game_state.dart';
import 'package:ludo_test/app/modules/ludo/data/models/token.dart';
import 'package:ludo_test/app/modules/ludo/tokenp.dart';
import 'package:ludo_test/app/modules/ludo/views/board_view.dart';

class GamePlay extends StatefulWidget {
  final GlobalKey keyBar;
  final GameState gameState;
  GamePlay(this.keyBar, this.gameState);
  @override
  _GamePlayState createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((context) {
      setState(() {
        boardBuild = true;
      });
    });
  }

  callBack(Token token) {
    print(token);
  }

  bool boardBuild = false;
  List<double> dimentions = [0, 0, 0, 0];
  final List<List<GlobalKey>> keyRefrences = _getGlobalKeys();
  static List<List<GlobalKey>> _getGlobalKeys() {
    List<List<GlobalKey>> keysMain = [];
    for (int i = 0; i < 15; i++) {
      List<GlobalKey> keys = [];
      for (int j = 0; j < 15; j++) {
        keys.add(GlobalKey());
      }
      keysMain.add(keys);
    }
    return keysMain;
  }

  List<double> _getPosition(int row, int column) {
    var listFrame = <double>[];
    double x;
    double y;
    double w;
    double h;
    if (widget.keyBar.currentContext == null) return [0, 0, 0, 0];
    final RenderBox renderBoxBar =
        (widget.keyBar.currentContext?.findRenderObject()) as RenderBox;
    final sizeBar = renderBoxBar.size;
    final cellBoxKey = keyRefrences[row][column];
    final RenderBox renderBoxCell =
        (cellBoxKey.currentContext?.findRenderObject()) as RenderBox;
    final positionCell = renderBoxCell.localToGlobal(Offset.zero);
    x = positionCell.dx + 1;
    y = (positionCell.dy - sizeBar.height + 1);
    w = renderBoxCell.size.width - 2;
    h = renderBoxCell.size.height - 2;
    listFrame.add(x);
    listFrame.add(y);
    listFrame.add(w);
    listFrame.add(h);
    return listFrame;
  }

  List<Tokenp> _getTokenList() {
    List<Tokenp> widgets = [];
    for (Token token in widget.gameState.gameTokens!) {
      widgets.add(Tokenp(token,
          _getPosition(token.tokenPosition.row, token.tokenPosition.column)));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [BoardView(keyReferences: keyRefrences), ..._getTokenList()]);
  }
}
