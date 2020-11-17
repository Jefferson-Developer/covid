import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
final String contactTable = "contactTable";
final String uidColumn = "uidColumn";
final String ufColumn = "ufColumn";
final String stateColumn = "stateColumn";
final String casesColumn = "casesColumn";
final String deathsColumn = "deathsColumn";
final String suspectsColumn = "suspectsColumn";
final String refusesColumn = "refusesColumn";
final String dateTimeColumn = "dateTimeColumn";

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;



  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contactsnew.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute(
              "CREATE TABLE $contactTable($uidColumn INTEGER PRIMARY KEY, $ufColumn TEXT, $stateColumn TEXT, $casesColumn INTEGER, "
                  "$deathsColumn INTEGER, $suspectsColumn INTEGER, $refusesColumn INTEGER, $dateTimeColumn TEXT)"
          );
        });
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    contact.uid = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [
          uidColumn,
          ufColumn,
          stateColumn,
          deathsColumn,
          dateTimeColumn
        ],
        where: "$uidColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "$uidColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$uidColumn = ?", whereArgs: [contact.uid]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }

    return listContact;
  }

   Future <Contact> dasds() async {
    const request = "https://covid19-brazil-api.now.sh/api/report/v1";
    List<Contact> endereco = [];
    List<dynamic> maps = [];
    http.Response response = await http.get(request);
    print(response.body);
    var toJson = json.decode(response.body);
    print(toJson["data"][0]);
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}

class Contact {
  int uid;
  String uf;
  String state;
  int cases;
  int deaths;
  int suspects;
  int refuses;
  String datetime;

  Contact();

  Contact.fromMap(Map map) {
    uid = map[uidColumn];
    uf = map[ufColumn];
    state = map[stateColumn];
    cases = map[casesColumn];
    deaths = map[deathsColumn];
    suspects = map[suspectsColumn];
    refuses = map[refusesColumn];
    datetime = map[dateTimeColumn];
  }
  Contact.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    uf = json['uf'];
    state = json['state'];
    cases = json['cases'];
    deaths = json['deaths'];
    suspects = json['suspects'];
    refuses = json['refuses'];
    datetime = json['datetime'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['uf'] = this.uf;
    data['state'] = this.state;
    data['cases'] = this.cases;
    data['deaths'] = this.deaths;
    data['suspects'] = this.suspects;
    data['refuses'] = this.refuses;
    data['datetime'] = this.datetime;
    return data;
  }
  Map toMap() {
    Map<String, dynamic> map = {
      ufColumn: uf,
      stateColumn: state,
      casesColumn: cases,
      deathsColumn: deaths,
      suspectsColumn: suspects,
      refusesColumn: refuses,
      dateTimeColumn: datetime,
    };
    if (uid != null) {
      map[uidColumn] = uid;
      return map;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(uid: $uid, uf: $uf, state: $state, cases: $cases, deaths: $deaths,suspects: $suspects, refuses: $refuses,datetime: $datetime  )";
  }
}
