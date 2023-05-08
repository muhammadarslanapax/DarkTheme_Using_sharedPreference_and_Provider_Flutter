import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../notes.dart';
class DB_Handler{
  static Database? _db;
  Future<Database?> get db async{
    if(_db!=null){
      return _db;
    }
    _db= await initDataBase();
    return _db;

  }
  initDataBase()async{

    // create path
    io.Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path,"notes.db");

    var db = openDatabase(path,version: 1,onCreate: _oncreate);
    return db;

  }

  FutureOr<void> _oncreate(Database db, int version) async {
    var query = "CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT , title TEXT NOT NULL, email TEXT NOT NULL) ";
    await db.execute(query);
  }
  Future<NotesModal> insert(NotesModal notesModal)async{
    var dbClint = await db;
    await dbClint!.insert("notes", notesModal.toMap());
    return notesModal;


  }



  Future<List<NotesModal>> getNotesList()async{
    var dbClint = await db;
    final List<Map<String,Object?>> queryres = await dbClint!.query("notes");
    return queryres.map((e) => NotesModal.fromJson(e)).toList();




  }




  Future<int> delete(int id)async{
    var dbClint = await db;


    return await dbClint!.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id]


    );



  }


  Future<int> update(NotesModal notesModal)async{
    var dbClint = await db;


    return await dbClint!.update(
        'notes',
        notesModal.toMap(),
      where: 'id = ?',
      whereArgs: [notesModal.id]


    );



  }










}