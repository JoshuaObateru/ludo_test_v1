import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../modules/ludo/data/models/game_state.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore firebaseFirestoreDb = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // final String userPath = "userWeights";
  // final String childPath = "weights";
  final String rooms = "game-rooms";
  late String userId;
  late CollectionReference ref;

  //game-rooms - ids - game-states

  FirebaseFirestoreService() {
    userId = firebaseAuth.currentUser!.uid;

    // ref = firebaseFirestoreDb
    //     .collection(userPath)
    //     .doc(userId)
    //     .collection(childPath);
    ref = firebaseFirestoreDb.collection(rooms);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.orderBy('timeStamp', descending: true).get();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.orderBy('timeStamp', descending: true).snapshots();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocumentById(String id) {
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map<String, Object> data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map<String, Object> data, String id) {
    return ref.doc(id).update(data);
  }

  //Ludo Specific app
  Stream<GameState> getGameState(String id) {
    return ref.doc(id).snapshots().map(_gameStateFromSnapshot);
  }

  GameState _gameStateFromSnapshot(DocumentSnapshot snapshot) {
    return GameState(
        starPositions: snapshot.get('starPositions'),
        blueInitital: snapshot.get('blueInitital'),
        currentTurn: snapshot.get('currentTurn'),
        gameTokens: snapshot.get('gameTokens'),
        greenInitital: snapshot.get('greenInitital'),
        numberOfTimesRolled: snapshot.get('numberOfTimesRolled'),
        redInitital: snapshot.get('redInitital'),
        shouldPlay: snapshot.get('shouldPlay'),
        yellowInitital: snapshot.get('yellowInitital'));
  }

  Future<DocumentReference> addGameState(Map<String, Object> data) {
    return ref.add(data);
  }

  Future<void> updateGameState(Map<String, Object> data, String id) {
    return ref.doc(id).update(data);
  }
}
