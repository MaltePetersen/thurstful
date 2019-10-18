import 'dart:developer' as prefix0;

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:wicolo/Repository/SentenceRepository.dart';
import 'package:wicolo/model/model.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [CardModel] does
/// _not_ depend on Provider.
class CardModel with ChangeNotifier {
  CardModel() {
    generateAppData();
    randomColor();
    randomType();
    randomSentence(typeNumber);
  }
  SentenceRepository sentenceRepository = SentenceRepository();
  Random rng = Random();
  MaterialColor color;
  String type;
  int typeNumber;
  String player;
  Sentence sentence = Sentence();
  //Umfrage = Type1; Spiel = Type2; Virus = Type3; Pflicht = Type4; Hab noch nie = Type5
  List types = ["Umfrage", "Spiel", "Virus", "Pflicht", "Hab noch nie"];
  List umfragen = ["user umfrage"];
  List spiele = ["user spiel"];
  List viruse = ["user virus"];
  List pflichte = ["user pflicht"];
  List habNochNiee = ["user hab noch nie"];
  List colors = [Colors.red, Colors.green, Colors.yellow];
  List<String> players = List();
  var quest1 = Sentence(id: 0, name: 'Umfrage user', sentenceType: 0);
  var quest2 = Sentence(id: 1, name: 'Spiel user', sentenceType: 1);
  var quest3 = Sentence(id: 2, name: 'Virus user', sentenceType: 2);
  var quest4 = Sentence(id: 3, name: 'pflicht user', sentenceType: 3);
  var quest5 = Sentence(id: 4, name: 'Hab noch nie user', sentenceType: 4);
  generateAppData() {
    insertSentence(quest1);
    insertSentence(quest2);
    insertSentence(quest3);
    insertSentence(quest4);
    insertSentence(quest5);
  }

  randomColor() {
    color = colors[rng.nextInt(colors.length)];
  }

  randomSentence(int numb) async {
  List<Sentence> list = await getBytype(numb);
  prefix0.log(list.length.toString() + ' ' + numb.toString());
    sentence = list[rng.nextInt(list.length)];
  }

  randomType() {
    typeNumber = rng.nextInt(types.length  );
    type = types[typeNumber];
  }

  randomPlayer() {
    player = players[rng.nextInt(players.length)];
  }

  updateCard() async{
    randomColor();
    randomType();
    await randomSentence(typeNumber);
    randomPlayer();
    notifyListeners();
    getBytype(1);
  }

  String getSentence() {
    return sentence.name.replaceAll("user", player);
  }

  String getType() {
    return type;
  }

  MaterialColor getColor() {
    return color;
  }

  String getPlayer() {
    return player;
  }

  void addAllPlayers(String playerOne, String playerTwo, String playerThree) {
    players.clear();
    players.add(playerOne);
    players.add(playerTwo);
    players.add(playerThree);
    randomPlayer();
  }

  insertSentence(Sentence sentence) {
    sentenceRepository.insertSentence(sentence);
  }

  updateSentence(Sentence sentence) {
    sentenceRepository.updateSentence(sentence);
  }

  deleteSentence(int id) {
    sentenceRepository.deleteSentence(id);
  }

  Future<List<Sentence>> getAllSentences() {
    return sentenceRepository.getAllSentences();
  }

  Future<List<Sentence>> getBytype(int i)  {
    return  sentenceRepository.getAllByType(i);
  }
}
