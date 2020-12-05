import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:exemple2/models/class_network.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database

  String tableNetwork = 'network';
  String colId = 'id';
  String colSurname = 'surname';
  String colForname = 'forname';
  String colTelnumber = 'telnumber';
  String colCateg = 'categ';
  String colDateAdded = 'dateAdded';

  DatabaseHelper._createInstance(); // constructeur nommé pour créer une instance de DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); //Ceci est exécuté une seule fois, c'est la notion singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //Obtenir le chemin où Android et iOS stockent les bases de données.
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'dbPierre2.db');

    //Créer et ouvrir la base de données
    var dbNetwork = await openDatabase(path, version: 4, onCreate: _createDb);

    await dbNetwork.insert(
      'network',
      {
        'id': 10,
        '$colSurname': 'smt-surname',
        '$colForname': 'smt-forname',
        '$colTelnumber': 12121212,
        '$colCateg': 'Pilates',
        '$colDateAdded': '2020-08-13'
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await dbNetwork.insert(
      'network',
      {
        'id': 20,
        '$colSurname': 'smt-surname33',
        '$colForname': 'smt-forname33',
        '$colTelnumber': 12121212,
        '$colCateg': 'Pilates',
        '$colDateAdded': '2020-08-14'
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return dbNetwork;
  }

  void _createDb(Database db, int hello) async {
    await db.execute(
        "CREATE TABLE $tableNetwork($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colSurname TEXT, $colForname TEXT, $colTelnumber INTEGER, $colCateg TEXT, $colDateAdded TEXT)");
  }

  //Opérations de CRUD
  //Obtention de tous les films (map)
  Future<List<Map<String, dynamic>>> getNetworkMapList() async {
    Database db = await this.database; //Appel à la méthode get database
    //var resultat =
    //await db.rawQuery('SELECT * FROM $tableFilms order by $colTitre ASC');
    var resultat = await db.query('$tableNetwork', orderBy: '$colSurname ASC');
    print('result: $resultat');
    return resultat;
  }

  //Insertion d'un film
  Future<int> addNetwork(Network aNetwork) async {
    Database db = await this.database;
    var resultat = await db.insert(tableNetwork, aNetwork.fromObjectToMap());
    return resultat;
  }

  //Mise-à-jour d'un film
  Future<int> updateNetwork(Network aNetwork) async {
    var db = await this.database;
    var resultat = await db.update(tableNetwork, aNetwork.fromObjectToMap(),
        where: '$colId = ?', whereArgs: [aNetwork.id]);
    return resultat;
  }

  //Supprimer un film
  Future<int> removeNetwork(int id) async {
    var db = await this.database;
    int resultat =
        await db.rawDelete('DELETE FROM $tableNetwork WHERE $colId = $id');
    return resultat;
  }

  //Obtenir le nombre de films dans la base de données
  Future<int> numberOfNetwork() async {
    Database db = await this.database;
    List<Map<String, dynamic>> networkList =
        await db.rawQuery('SELECT COUNT (*) from $tableNetwork');
    int nbNetwork = Sqflite.firstIntValue(networkList);
    return nbNetwork;
  }

  //À partir de la liste de Map on va générer une liste d'objets Film
  Future<List<Network>> getNetworkList() async {
    List<Network> listNetworkObjects = List<Network>();
    var networkMapList =
        await getNetworkMapList(); //Liste map de la base de données
    //Créer la liste d'objets Film à partir de filmMapList
    listNetworkObjects = networkMapList
        .map((aMapNetwork) => Network.fromMapToObject(aMapNetwork))
        .toList();
    return listNetworkObjects;
  }
}
