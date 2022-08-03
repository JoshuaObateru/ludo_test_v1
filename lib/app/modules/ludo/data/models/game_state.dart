import 'package:flutter/material.dart';
import 'package:ludo_test/app/modules/ludo/data/models/position.dart';
import 'package:ludo_test/app/modules/ludo/data/models/token.dart';
import 'package:ludo_test/app/modules/ludo/data/models/path.dart';
import 'package:ludo_test/app/services/firebase_firestore_service.dart';

class GameState with ChangeNotifier {
  FirebaseFirestoreService firebaseFirestoreService =
      FirebaseFirestoreService();
  // List<Token> gameTokens = List<Token>(16);
  List<Token>? gameTokens = <Token>[];
  List<Position>? starPositions;
  List<Position>? greenInitital;
  List<Position>? yellowInitital;
  List<Position>? blueInitital;
  List<Position>? redInitital;
  int? currentTurn;
  int? numberOfTimesRolled; // applicaple when a 6 is rolled
  bool? shouldPlay;
  String? roomId;
  GameState(
      {this.starPositions,
      this.greenInitital,
      this.yellowInitital,
      this.blueInitital,
      this.redInitital,
      this.currentTurn,
      this.numberOfTimesRolled,
      this.shouldPlay,
      this.gameTokens}) {
    gameTokens = [
      //Green Tokens home
      Token(TokenType.green, Position(2, 2), TokenState.initial, 0, 1),
      Token(TokenType.green, Position(2, 3), TokenState.initial, 1, 1),
      Token(TokenType.green, Position(3, 2), TokenState.initial, 2, 1),
      Token(TokenType.green, Position(3, 3), TokenState.initial, 3, 1),
      //Yellow Token
      Token(TokenType.yellow, Position(2, 11), TokenState.initial, 4, 2),
      Token(TokenType.yellow, Position(2, 12), TokenState.initial, 5, 2),
      Token(TokenType.yellow, Position(3, 11), TokenState.initial, 6, 2),
      Token(TokenType.yellow, Position(3, 12), TokenState.initial, 7, 2),
      // Blue Token
      Token(TokenType.blue, Position(11, 11), TokenState.initial, 8, 3),
      Token(TokenType.blue, Position(11, 12), TokenState.initial, 9, 3),
      Token(TokenType.blue, Position(12, 11), TokenState.initial, 10, 3),
      Token(TokenType.blue, Position(12, 12), TokenState.initial, 11, 3),
      // Red Token
      Token(TokenType.red, Position(11, 2), TokenState.initial, 12, 4),
      Token(TokenType.red, Position(11, 3), TokenState.initial, 13, 4),
      Token(TokenType.red, Position(12, 2), TokenState.initial, 14, 4),
      Token(TokenType.red, Position(12, 3), TokenState.initial, 15, 4),
    ];

    //Does this mean all the possible positions??
    starPositions = [
      Position(6, 1),
      Position(2, 6),
      Position(1, 8),
      Position(6, 12),
      Position(8, 13),
      Position(12, 8),
      Position(13, 6),
      Position(8, 2)
    ];
    greenInitital = [];
    yellowInitital = [];
    blueInitital = [];
    redInitital = [];
    currentTurn = 1;
    numberOfTimesRolled = 0;
    shouldPlay = false;
    roomId =
        "${gameTokens![0].positionInPath}-${gameTokens![4].positionInPath}-${gameTokens![8].positionInPath}-${gameTokens![12].positionInPath}";
    firebaseFirestoreService.addDocument({
      'starPositions': starPositions!,
      'blueInitital': blueInitital!,
      'currentTurn': currentTurn!,
      'gameTokens': gameTokens!,
      'greenInitital': greenInitital!,
      'numberOfTimesRolled': numberOfTimesRolled!,
      'redInitital': redInitital!,
      'shouldPlay': shouldPlay!,
      'yellowInitital': yellowInitital!
    });
  }

  checkShouldPlay(int steps) {
    // Token tokenn = gameTokens.firstWhere((tok) => tok.turn == currentTurn);
    // Future.delayed(const Duration(seconds: 1), () {
    var isSelectedArr = [];
    for (int i = 0; i < gameTokens!.length; i++) {
      Token token = gameTokens![i];
      if (token.turn == currentTurn) {
        if (token.tokenState == TokenState.initial &&
            steps == 6 &&
            token.turn == currentTurn) {
          shouldPlay = true;
          isSelectedArr.add(true);
          print(
              "ShouldPlayy 1 $shouldPlay, ${token.tokenState}, ${token.turn}, $currentTurn, $steps");
        } else if (token.tokenState != TokenState.initial &&
            token.turn == currentTurn) {
          shouldPlay = true;
          isSelectedArr.add(true);
          print(
              "ShouldPlayy 1 $shouldPlay, ${token.tokenState}, ${token.turn}, $currentTurn, $steps");
        } else {
          shouldPlay = false;
          isSelectedArr.add(false);
          print(
              "ShouldPlayy 1 $shouldPlay, ${token.tokenState}, ${token.turn}, $currentTurn, $steps");
        }
      }
    }
    shouldPlay = isSelectedArr.contains(true);
    // });
  }

  updateCurrentTurn() {
    if (currentTurn! < 4) {
      currentTurn = currentTurn! + 1;
    } else {
      currentTurn = 1;
    }
    notifyListeners();
  }

  updateGameTurn(int steps) {
    // notifyListeners();
    if (steps == 6) {
      // set play to true
      if (numberOfTimesRolled! < 3) {
        numberOfTimesRolled = numberOfTimesRolled! + 1;
        // notifyListeners();
      } else {
        numberOfTimesRolled = 0;
        var future = Future.delayed(const Duration(seconds: 1), () {
          updateCurrentTurn();
        });
      }
    } else {
      numberOfTimesRolled = 0;
      var future = Future.delayed(const Duration(seconds: 1), () {
        updateCurrentTurn();
      });
    }
    // var future = Future.delayed(const Duration(seconds: 2), () {
    //   if (steps == 6) {
    //     if (numberOfTimesRolled! < 3) {
    //       numberOfTimesRolled = numberOfTimesRolled! + 1;
    //       // notifyListeners();
    //     } else {
    //       numberOfTimesRolled = 0;
    //       updateCurrentTurn();
    //     }
    //   } else {

    //   }
    // });
  }

  moveToken(Token token, int steps) {
    Position destination;
    int pathPosition;
    if (token.tokenState == TokenState.home) return;
    if (token.tokenState == TokenState.initial && steps != 6) {
      // if (currentTurn! < 4) {
      //   currentTurn = currentTurn! + 1;
      // } else {
      //   currentTurn = 1;
      // }
      // notifyListeners();
      // var future = Future.delayed(const Duration(seconds: 1), () {
      //   updateGameTurn(steps);

      //   print("c $steps");
      //   print("diceoneee ${steps}");
      // });

      return;
    }
    if (token.tokenState == TokenState.initial &&
        steps == 6 &&
        token.turn == currentTurn &&
        shouldPlay == true) {
      destination = _getPosition(token.type, 0);
      pathPosition = 0;
      _updateInitalPositions(token);
      _updateBoardState(token, destination, pathPosition);
      gameTokens![token.id].tokenPosition = destination;
      gameTokens![token.id].positionInPath = pathPosition;
      print("tokenId is: ${token.id}");
      var future = Future.delayed(const Duration(seconds: 1), () {
        shouldPlay = false;
        updateGameTurn(steps);

        print("c $steps");
        print("diceoneee ${steps}");
      });
      notifyListeners();
    } else if (token.tokenState != TokenState.initial &&
        token.turn == currentTurn &&
        shouldPlay == true) {
      int step = token.positionInPath! + steps;
      if (step > 56) return;
      destination = _getPosition(token.type, step);
      pathPosition = step;
      var cutToken = _updateBoardState(token, destination, pathPosition);
      int duration = 0;
      for (int i = 1; i <= steps; i++) {
        duration = duration + 500;
        var future = Future.delayed(Duration(milliseconds: duration), () {
          int stepLoc = token.positionInPath! + 1;
          gameTokens![token.id].tokenPosition =
              _getPosition(token.type, stepLoc);
          print("token type: ${token.type}");
          gameTokens![token.id].positionInPath = stepLoc;
          token.positionInPath = stepLoc;

          notifyListeners();
        });
      }
      if (cutToken != null) {
        int cutSteps = cutToken.positionInPath!;
        for (int i = 1; i <= cutSteps; i++) {
          duration = duration + 100;
          var future2 = Future.delayed(Duration(milliseconds: duration), () {
            int stepLoc = cutToken.positionInPath! - 1;
            gameTokens![cutToken.id].tokenPosition =
                _getPosition(cutToken.type, stepLoc);
            gameTokens![cutToken.id].positionInPath = stepLoc;
            cutToken.positionInPath = stepLoc;

            notifyListeners();
          });
        }
        var future2 = Future.delayed(Duration(milliseconds: duration), () {
          _cutToken(cutToken);
          // if (currentTurn! < 4) {
          //   currentTurn = currentTurn! + 1;
          // } else {
          //   currentTurn = 1;
          // }
          notifyListeners();
        });
      }
      var future = Future.delayed(const Duration(seconds: 1), () {
        shouldPlay = false;
        updateGameTurn(steps);

        print("c $steps");
        print("diceoneee ${steps}");
      });
    }
  }

  Token? _updateBoardState(
      Token token, Position destination, int pathPosition) {
    Token? cutToken;
    //when the destination is on any star
    if (starPositions!.contains(destination)) {
      gameTokens![token.id].tokenState = TokenState.safe;
      //this.gameTokens![token.id].tokenPosition = destination;
      //this.gameTokens![token.id].positionInPath = pathPosition;
      return null;
    }
    List<Token> tokenAtDestination = gameTokens!.where((tkn) {
      if (tkn.tokenPosition == destination) {
        return true;
      }
      return false;
    }).toList();
    //if no one at the destination
    if (tokenAtDestination.length == 0) {
      gameTokens![token.id].tokenState = TokenState.normal;
      //this.gameTokens![token.id].tokenPosition = destination;
      //this.gameTokens![token.id].positionInPath = pathPosition;
      return null;
    }
    //check for same color at destination
    List<Token> tokenAtDestinationSameType = tokenAtDestination.where((tkn) {
      if (tkn.type == token.type) {
        return true;
      }
      return false;
    }).toList();
    if (tokenAtDestinationSameType.length == tokenAtDestination.length) {
      for (Token tkn in tokenAtDestinationSameType) {
        gameTokens![tkn.id].tokenState = TokenState.safeinpair;
      }
      gameTokens![token.id].tokenState = TokenState.safeinpair;
      //this.gameTokens![token.id].tokenPosition = destination;
      //this.gameTokens![token.id].positionInPath = pathPosition;
      return null;
    }
    if (tokenAtDestinationSameType.length < tokenAtDestination.length) {
      for (Token tkn in tokenAtDestination) {
        if (tkn.type != token.type && tkn.tokenState != TokenState.safeinpair) {
          //cut an unsafe token
          //_cutToken(tkn);
          cutToken = tkn;
        } else if (tkn.type == token.type) {
          gameTokens![tkn.id].tokenState = TokenState.safeinpair;
        }
      }
      //place token
      gameTokens![token.id].tokenState = tokenAtDestinationSameType.length > 0
          ? TokenState.safeinpair
          : TokenState.normal;
      // this.gameTokens![token.id].tokenPosition = destination;
      // this.gameTokens![token.id].positionInPath = pathPosition;
      return cutToken;
    }
  }

  _updateInitalPositions(Token token) {
    switch (token.type) {
      case TokenType.green:
        {
          if (currentTurn == 1) {
            print("current turn is: $currentTurn");
            greenInitital?.add(token.tokenPosition);
          }
        }
        break;
      case TokenType.yellow:
        {
          if (currentTurn == 2) {
            print("current turn is: $currentTurn");
            yellowInitital?.add(token.tokenPosition);
          }
        }
        break;
      case TokenType.blue:
        {
          if (currentTurn == 3) {
            print("current turn is: $currentTurn");
            blueInitital?.add(token.tokenPosition);
          }
        }
        break;
      case TokenType.red:
        {
          if (currentTurn == 4) {
            print("current turn is: $currentTurn");
            redInitital?.add(token.tokenPosition);
          }
        }
        break;
    }
  }

  _cutToken(Token token) {
    switch (token.type) {
      case TokenType.green:
        {
          gameTokens![token.id].tokenState = TokenState.initial;
          gameTokens![token.id].tokenPosition = greenInitital!.first;
          greenInitital?.removeAt(0);
        }
        break;
      case TokenType.yellow:
        {
          gameTokens![token.id].tokenState = TokenState.initial;
          gameTokens![token.id].tokenPosition = yellowInitital!.first;
          yellowInitital?.removeAt(0);
        }
        break;
      case TokenType.blue:
        {
          gameTokens![token.id].tokenState = TokenState.initial;
          gameTokens![token.id].tokenPosition = blueInitital!.first;
          blueInitital?.removeAt(0);
        }
        break;
      case TokenType.red:
        {
          gameTokens![token.id].tokenState = TokenState.initial;
          gameTokens![token.id].tokenPosition = redInitital!.first;
          redInitital?.removeAt(0);
        }
        break;
    }
  }

  // Position _getPosition(TokenType type, step) {
  //   Position destination;
  //   switch (type) {
  //     case TokenType.green:
  //       {
  //         List<int> node = Path.greenPath[step];
  //         destination = Position(node[0], node[1]);
  //       }
  //       break;
  //     case TokenType.yellow:
  //       {
  //         List<int> node = Path.yellowPath[step];
  //         destination = Position(node[0], node[1]);
  //       }
  //       break;
  //     case TokenType.blue:
  //       {
  //         List<int> node = Path.bluePath[step];
  //         destination = Position(node[0], node[1]);
  //       }
  //       break;
  //     case TokenType.red:
  //       {
  //         List<int> node = Path.redPath[step];
  //         destination = Position(node[0], node[1]);
  //       }
  //       break;
  //   }
  //   return destination;
  // }

  Position _getPosition(TokenType type, step) {
    Position destination;
    switch (type) {
      case TokenType.green:
        {
          List<int> node = Path.greenPath[step];
          destination = Position(node[0], node[1]);
        }
        break;
      case TokenType.yellow:
        {
          List<int> node = Path.yellowPath[step];
          destination = Position(node[0], node[1]);
        }
        break;
      case TokenType.blue:
        {
          List<int> node = Path.bluePath[step];
          destination = Position(node[0], node[1]);
        }
        break;
      case TokenType.red:
        {
          List<int> node = Path.redPath[step];
          destination = Position(node[0], node[1]);
        }
        break;
      default:
        List<int> node = Path.greenPath[step];
        destination = Position(node[0], node[1]);
    }

    return destination;
  }
}
