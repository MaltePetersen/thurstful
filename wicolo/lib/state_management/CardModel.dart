import 'package:flutter/material.dart';
import 'dart:math';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [CardModel] does
/// _not_ depend on Provider.
class CardModel with ChangeNotifier {
CardModel(){
  randomColor();
  randomType();
}
  Random rng = Random();
  MaterialColor color;
  String type;
  String player;
  List types = ["Umfrage", "Spiel", "Virus", "Pflicht", "Hab noch nie"];
  List colors = [Colors.red, Colors.green, Colors.yellow];
  List<String> players = List();
  randomColor() {
    color = colors[rng.nextInt(colors.length)];
  }

  randomType() {
    type = types[rng.nextInt(types.length)];
  }

  randomPlayer() {
    player = players[rng.nextInt(players.length)];
  }

  updateCard() {
    randomColor();
    randomType();
    randomPlayer();
    notifyListeners();
  }

  String getType() {
    return type;
  }
  MaterialColor getColor(){
    return color;
  }
  String getPlayer(){
    return player;
  }



  void addAllPlayers(String playerOne, String playerTwo, String playerThree) {
    players.clear();
    players.add(playerOne);
    players.add(playerTwo);
    players.add(playerThree);
    randomPlayer();
  }
}
