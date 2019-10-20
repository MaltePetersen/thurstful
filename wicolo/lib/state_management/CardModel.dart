import 'dart:developer' as prefix0;

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:math';
import 'package:wicolo/Repository/SentenceRepository.dart';
import 'package:wicolo/model/model.dart';
import 'package:http/http.dart' as http;

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [CardModel] does
/// _not_ depend on Provider.
class CardModel with ChangeNotifier {
  SentenceRepository sentenceRepository = SentenceRepository();
  Random rng = Random();
  MaterialColor color;
  int type;
  String currentType;
  String player;
  Sentence sentence = Sentence();
  List colors = [Colors.red, Colors.green, Colors.blue];
  List<String> players = List();

  CardModel() {
    randomColor();
    randomSentence();
  }

  randomColor() {
    color = colors[rng.nextInt(colors.length)];
  }

  randomSentence() async {
    type = rng.nextInt(4);
    currentType = await sentenceRepository.getCategorieById(type);
    prefix0.log(currentType);
    List<Sentence> list = await getBytype(type);
    sentence = list[rng.nextInt(list.length)];
  }

  randomPlayer() {
    player = players[rng.nextInt(players.length)];
  }

  updateCard() async {
    randomColor();
    await randomSentence();
    randomPlayer();
    notifyListeners();
fetchPost();
  }

  String getSentence() {
    return sentence.name.replaceAll("user", player);
  }

  String getType() {
    return currentType;
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

  Future<List<Sentence>> getBytype(int i) {
    return sentenceRepository.getAllByType(i);
  }

  Future<http.Response> fetchPost() async {
    int version = await sentenceRepository.getDBVersion();
    Response backendVersionResponse = await http.get('https://springwicolo.herokuapp.com/version');
    int backendVersion  = int.parse( backendVersionResponse.body);
    prefix0.log(version.toString() + ' ' + backendVersion.toString());
  }
}
