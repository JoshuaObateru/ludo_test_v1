import 'package:ludo_test/app/modules/ludo/data/models/position.dart';

enum TokenType { green, yellow, blue, red }

enum TokenState { initial, home, normal, safe, safeinpair }

class Token {
  final int id;
  final TokenType type;
  Position tokenPosition;
  TokenState tokenState;
  int? positionInPath;
  final int turn;
  Token(this.type, this.tokenPosition, this.tokenState, this.id, this.turn);
}
