import 'package:flutter/material.dart';
import 'package:ludo_test/utility.dart';

class LudoRow extends StatelessWidget {
  const LudoRow({Key? key, required this.row, required this.keyRow})
      : super(key: key);

  final int row;
  final List<GlobalKey> keyRow;
  List<Flexible> _getColumns() {
    List<Flexible> columns = [];
    for (var i = 0; i < 15; i++) {
      columns.add(Flexible(
        key: keyRow[i],
        child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.grey),
                  right: i == 14
                      ? BorderSide(color: Colors.grey)
                      : BorderSide.none,
                ),
                color: Utility.getColor(row, i) //Colors.transparent,
                ),
            //child: Text('${row},${i}'),
          ),
        ),
      ));
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[..._getColumns()],
    );
  }
}
