import 'dart:developer' as prefix0;

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

import 'package:sqflite/sqlite_api.dart';

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
        join(await getDatabasesPath(), 'databaseTest.db'),
        // When the database is first created, create a table to store dogs.
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE sentences(id INTEGER PRIMARY KEY, name TEXT)",
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
      );
    return database;
  }

  Future<void> insertDog(Sentence dog) async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'sentences',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    var allDogs = await dogs();
    allDogs.forEach((f) => {prefix0.log(f.toString())});
  }

  Future<List<Sentence>> dogs() async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('sentences');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Sentence(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<void> updateDog(Sentence dog) async {
    // Get a reference to the database.
    final db = await getDatabase();

    // Update the given Dog.
    await db.update(
      'sentences',
      dog.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [dog.id],
    );
  }

  Future<void> deleteDog(int id) async {
    // Get a reference to the database.
    final db = await getDatabase();

    // Remove the Dog from the database.
    await db.delete(
      'sentences',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}

class Sentence {
  final int id;
  final String name;

  Sentence({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
          };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name}';
  }
}
