import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wicolo/model/Version.dart';
import 'package:wicolo/model/model.dart';
import 'dart:developer' as prefix0;

class SentenceRepository {
  Future database;

  Future<Database> getDatabase() async {
    if (database == null)
      database = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.
        join(await getDatabasesPath(), 'thurstfullDatabase13378.db'),
        // When the database is first created, create a table to store sentences.
        onCreate: _onCreat,
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
      );

    return database;
  }

  _onCreat(db, version) {
    db.execute("CREATE TABLE version(id INTEGER PRIMARY KEY, versionNum INTEGER )");
    db.rawInsert(" INsert into version values(1, 1)"); 
    db.execute(
        "CREATE TABLE sentences(id INTEGER PRIMARY KEY, name TEXT, sentenceType INTEGER )");
    db.rawInsert(
        "INsert into sentences values(0,'Wer hatte am meisten Sexpartner?', 1)");
    db.rawInsert(
        "INsert into sentences values(1,'user sucht sich einen Trinkbuddy aus', 2)");
    db.rawInsert(
        "INsert into sentences values(2,'Biersorten aufzählen. user fängt an', 3)");
    db.rawInsert(
        "INsert into sentences values(3,'user erzählt seine peinlichste Suffstory', 4)");
    db.rawInsert(
        "INsert into sentences values(4,'Wer hatte noch nie Analsex', 5)");
    db.rawInsert(
        "INsert into sentences values(5,'Wer hatte das beste Abitur?', 1)");
    db.rawInsert(
        "INsert into sentences values(6,'Wasserfall user fängt an', 2)");
    db.rawInsert(
        "INsert into sentences values(7,'Schauspieler aufzählen, user fängt an', 3)");
    db.rawInsert(
        "INsert into sentences values(8,'user lehrt sein  Getränk', 4)");
    db.rawInsert(
        "INsert into sentences values(9,'Ich hab noch nie mit einem der Mitspieler geschlafen', 5)");
    db.execute(
        "CREATE TABLE categories(id INTEGER PRIMARY KEY, categorie text)");
    db.rawInsert("Insert into categories values(1,'Umfrage')");
    db.rawInsert("Insert into categories values(2,'Spiel')");
    db.rawInsert("Insert into categories values(3,'Virus')");
    db.rawInsert("Insert into categories values(4,'Pflicht')");
    return db.rawInsert("Insert into categories values(5,'Hab noch nie')");
  }

  updateDatabase(List<Sentence> sentence, int backendVersion) async {
    final Database database = await getDatabase();

    database.execute("DROP TABLE IF EXISTS sentences");
        database.execute(
        "CREATE TABLE sentences(id INTEGER PRIMARY KEY, name TEXT, sentenceType INTEGER )");
    sentence.forEach((f) => insertSentence(f));
    database.setVersion(backendVersion);
        insertVersion(Version(id: 1, versionNum: 0 ));
    getDBVersion().then((onValue)=> prefix0.log(onValue.toString()));
  }
 Future<void> insertVersion(Version version, {int id}) async {
    // Get a reference to the database.
    final Database db = await getDatabase();
    // Insert the Sentence into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same sentence is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'version',
      version.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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

  Future<List<Sentence>> getAllByType(int type) async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Query the table for all The Sentences.
    final List<Map<String, dynamic>> maps = await db.query(
      'sentences',
      // Ensure that the Sentence has a matching id.
      where: "sentenceType = $type",
    );

    // Convert the List<Map<String, dynamic> into a List<Sentence>.
    return List.generate(maps.length, (i) {
      return Sentence(
        id: maps[i]['id'],
        name: maps[i]['name'],
        sentenceType: maps[i]['sentenceType'],
      );
    });
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

  Future<int> getDBVersion() async {
    final db = await getDatabase();
     List<Map<String, dynamic>> futList = await db.query('version',where: "id = 1");
    return futList[0]['versionNum']; 
  }

  Future<String> getCategorieById(int type) async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Query the table for all The Sentences.

    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      // Ensure that the Sentence has a matching id.
      where: "id = $type",
    );
    return maps[0]['categorie'];
  }
}
