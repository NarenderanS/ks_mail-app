import 'dart:io';

import 'package:ks_mail/src/data/models/mail.dart';
import 'package:ks_mail/src/data/models/mail_status.dart';
import 'package:ks_mail/src/data/models/recipient.dart';
import 'package:ks_mail/src/data/datasources/local/database/default_mails.dart';
import 'package:ks_mail/src/data/datasources/local/database/default_users.dart';
import 'package:ks_mail/src/utils/constants/variables.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? db;
  final databaseName = "ksMail.db";

  Future<Database> get database async {
    if (db != null) {
      print("exist");
      return db!;
    }
    db = await initializeDB();
    return db!;
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    final databasePath = join(path, databaseName);
    print(databasePath);

    print("instance created");
    return openDatabase(
      databasePath,
      onCreate: _createDB,
      version: 1,
    );
  }

  void _createDB(database, version) async {
    // Create User Table
    await database.execute('CREATE TABLE IF NOT EXISTS ${Table.user}('
        '$id INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$username TEXT NOT NULL,'
        '$mail TEXT NOT NULL,'
        '$phoneNo INTEGER,'
        '$password TEXT NOT NULL,'
        '$createdAt TEXT)');
    print('user Table created');
    // Create Mail table
    await database.execute(
      'CREATE TABLE IF NOT EXISTS ${Table.mail}('
      '$id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$from INTEGER,'
      '$subject TEXT,'
      '$body TEXT,'
      '$draft INTEGER DEFAULT 0,'
      '$createdAt TEXT,'
      '$updatedAt TEXT,'
      'FOREIGN KEY ($from) REFERENCES ${Table.user}($id))',
    );
    print("mail Table created");

    // Create Recipients table
    await database.execute(
      'CREATE TABLE IF NOT EXISTS ${Table.recipient}('
      '$id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$mailId INTEGER,'
      '$userId INTEGER,'
      '$recipientType TEXT,'
      'FOREIGN KEY ($mailId) REFERENCES ${Table.mail}($id),'
      'FOREIGN KEY ($userId) REFERENCES ${Table.user}($id))',
    );
    print("recipient Table created");
    // Create MailStatus table
    await database.execute(
      'CREATE TABLE IF NOT EXISTS ${Table.status}('
      '$id INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$mailId INTEGER,'
      '$userId INTEGER,'
      '$statusType TEXT,'
      'FOREIGN KEY ($mailId) REFERENCES ${Table.mail}($id),'
      'FOREIGN KEY ($userId) REFERENCES ${Table.user}($id))',
    );
    print("status Table created");
    // Add users
    for (var u in user) {
      // Insert each value into the database
      await database.insert(Table.user, u.toMap());
    }
    // Add mails
    for (var mail in mails) {
      // Insert each value into the database
      int mailId;
      // add data to mailTable
      mailId = await database.insert(
        Table.mail,
        mapToMailModel(mail).toMap(),
      );
      print('Loaded $mailId');
      // add data to recipentTable
      List<RecipientModel> recipients = mapToRecipientModel(mail, mailId);
      for (var recipient in recipients) {
        await database.insert(
          Table.recipient,
          recipient.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      // add data to mailStatusTable
      List<MailStatusModel> statuses = mapToMailStatusModel(mail, mailId);
      for (var status in statuses) {
        await database.insert(
          Table.status,
          status.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      print("Mail ${mailId} added to db");
      // return mailId;
    }
    print("Transfer Mail Completed");
  }

  Future<void> showTables() async {
    Database db = await getDatabase();
    // Query the sqlite_master table to get information about all tables
    List<Map<String, dynamic>> tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
    print(
        '------------------------------------------------------------------------------');
    // Print the names of all tables
    for (Map<String, dynamic> table in tables) {
      print(table['name']);
    }
    print(
        '--------------------------------------------------------------------------------');
  }

  static Future<void> deleteDatabase() async {
    String path = await getDatabasesPath();
    final databasePath = join(path, "ksMail.db");
    // Check if the database file exists
    bool dbExists = await File(databasePath).exists();
    if (dbExists) {
      // Delete the database file
      await File(databasePath).delete();
      print("Db Deleted");
    }
  }

  static Future<void> deleteTables() async {
    Database db = await getDatabase();
    // await db.execute('DROP TABLE IF EXISTS ${Table.user}');
    // print("user Table deleted");

    await db.execute('DROP TABLE IF EXISTS ${Table.mail}');
    print("mail Table deleted");

    await db.execute('DROP TABLE IF EXISTS ${Table.recipient}');
    print("recipient Table deleted");

    await db.execute('DROP TABLE IF EXISTS ${Table.status}');
    print("status Table deleted");
  }

  static Future<void> deleteAllUserRows() async {
    print("called");
    // Get a reference to the database
    Database db = await getDatabase();
    // Execute the SQL DELETE statement
    await db.delete(Table.user);
  }

  static Future<void> deleteAllMailRows() async {
    print("called");
    // Get a reference to the database
    Database db = await getDatabase();
    // Execute the SQL DELETE statement
    await db.delete(Table.mail);
    await db.delete(Table.recipient);
    await db.delete(Table.status);
  }
}

Future<Database> getDatabase() async {
  if (DBHelper.db == null) {
    await DBHelper().database;
  }
  Database? database = DBHelper.db;
  if (database != null) {
    return database;
  } else {
    throw Exception('Database is not initialized.');
  }
}
