
// ignore_for_file: require_trailing_commas


import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'notification_details.dart';

/// Listens for incoming foreground messages and displays them in a list.
class MessageList extends StatefulWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageList();
}

class _MessageList extends State<MessageList> {
  List<RemoteMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      setState(() {
        _messages = [..._messages, message];
             DatabaseHelper.instance
                .add(Grocery(name: message.notification?.title??'N/D', text: message.notification?.body??'N/D'));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_messages.isEmpty) {
      return const Text('No messages received');
    }

    return SingleChildScrollView(
      child: FutureBuilder<List<Grocery>>(
          future: DatabaseHelper.instance.getGroceries(),
          builder: (BuildContext context, AsyncSnapshot<List<Grocery>> snapshot) {
      if (!snapshot.hasData) {
        return const Center(
          child: Text('alter, ich warte....'),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(margin: EdgeInsets.all(5),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!.map((grocery) {
                  return Container(decoration: BoxDecoration(
        
            border: Border.all(
                color: Colors.amber, // Set border color
                width: 3.0),   // Set border width
            borderRadius: BorderRadius.all(
                Radius.circular(10.0)), // Set rounded corner radius
            boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
        ),
                    child: Column(children:[ Text(grocery.name),
                     Text(grocery.text),
                     Text(DateTime.now().toString(),)
                  
                     ]
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      );
          },
        ),
    );
  }
}

class Grocery {
  final int? id;
  final String name;
  final String text;

  Grocery({this.id, required this.name, required this.text});

  factory Grocery.fromMap(Map<String, dynamic> json) => Grocery(
        id: json['id'],
        name: json['name'],
        text:json['text'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'text':text,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'notification.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE notification(id INTEGER PRIMARY KEY, name TEXT, text TEXT)''');
  }

  Future<List<Grocery>> getGroceries() async {
    Database db = await instance.database;
    var groceries = await db.query('notification',orderBy: 'name' );
    List<Grocery> groceryList = groceries.isNotEmpty
        ? groceries.map((c) => Grocery.fromMap(c)).toList()
        : [];
    return groceryList;
  }

  Future<int> add(Grocery grocery) async {
    Database db = await instance.database;
    return await db.insert('notification', grocery.toMap());
  }
}
