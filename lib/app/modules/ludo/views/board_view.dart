import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ludo_test/app/modules/ludo/ludo_row.dart';

class BoardView extends GetView {
  BoardView({Key? key, required this.keyReferences}) : super(key: key);

  List<List<GlobalKey>> keyReferences;

  List<Container> _getRows() {
    List<Container> rows = [];
    for (var i = 0; i < 15; i++) {
      rows.add(Container(
        child: LudoRow(row: i, keyRow: keyReferences[i]),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey),
              bottom:
                  i == 14 ? BorderSide(color: Colors.grey) : BorderSide.none),
          color: Colors.transparent,
        ),
      ));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/Ludo_board.png",
                ),
                fit: BoxFit.fitWidth),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[..._getRows()],
          ),
        ),
      ),
    );
  }
}
