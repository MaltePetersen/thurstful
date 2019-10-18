import 'dart:developer' as prefix0;

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

import 'package:sqflite/sqlite_api.dart';
import 'package:wicolo/model/model.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`. [CardModel] does
/// _not_ depend on Provider.
class CardModel with ChangeNotifier {
  Future database;

  CardModel() {
    randomColor();
    randomType();
    randomSentece();
  }
  Random rng = Random();
  MaterialColor color;
  String type;
  String player;
  String sentence;
  List types = ["Umfrage", "Spiel", "Virus", "Pflicht", "Hab noch nie"];
  List sentences = ["user moin", "user moin2"];
  List colors = [Colors.red, Colors.green, Colors.yellow];
  List<String> players = List();
  randomColor() {
    color = colors[rng.nextInt(colors.length)];
  }

  randomSentece() {
    sentence = sentences[rng.nextInt(sentences.length)];
  }

  randomType() {
    type = types[rng.nextInt(types.length)];
  }

  randomPlayer() {
    player = players[rng.nextInt(players.length)];
  }

  updateCard() {
    randomColor();
    randomSentece();
    randomType();
    randomPlayer();
    notifyListeners();
  }

  String getSentence() {
    return sentence.replaceAll("user", player);
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

  Future<Database> getDatabase() async {
    if (database == null)
      database = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'databaseTew.db'),
        // When the database is first created, create a table to store sentences.
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE sentences(id INTEGER PRIMARY KEY, name TEXT, sentenceType INTEGER )",
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
      );
    return database;
  }

  Future<void> insertSentence(Sentence sentence) async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Insert the Sentence into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same sentence is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'sentences',
      sentence.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    var allSentences = await getAllSentences();
    allSentences.forEach((f) => {prefix0.log(f.toString())});
  }

  Future<List<Sentence>> getAllSentences() async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Query the table for all The Sentences.
    final List<Map<String, dynamic>> maps = await db.query('sentences');

    // Convert the List<Map<String, dynamic> into a List<Sentence>.
    return List.generate(maps.length, (i) {
      return Sentence(
        id: maps[i]['id'],
        name: maps[i]['name'],
        sentenceType: maps[i]['sentenceType'],
      );
    });
  }

  Future<void> updateSentence(Sentence sentence) async {
    // Get a reference to the database.
    final db = await getDatabase();

    // Update the given Sentence.
    await db.update(
      'sentences',
      sentence.toMap(),
      // Ensure that the Sentence has a matching id.
      where: "id = ?",
      // Pass the Sentence's id as a whereArg to prevent SQL injection.
      whereArgs: [sentence.id],
    );
  }

  Future<void> deleteSentence(int id) async {
    // Get a reference to the database.
    final db = await getDatabase();

    // Remove the Sentence from the database.
    await db.delete(
      'sentences',
      // Use a `where` clause to delete a specific sentence.
      where: "id = ?",
      // Pass the Sentence's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
