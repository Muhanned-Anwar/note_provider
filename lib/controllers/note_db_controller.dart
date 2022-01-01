import 'package:note_provider/models/note.dart';
import 'package:note_provider/storage/db/db_operations.dart';
import 'package:note_provider/storage/db/db_provider.dart';
import 'package:sqflite/sqflite.dart';

class NoteDbController extends DbOperations<Note> {
  Database database = DbProvider().database;

  @override
  Future<int> create(Note object) async {
    int newRowId = await database.insert('notes', object.toMap()); //
    return newRowId;
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeleteRows =
        await database.delete('notes', where: 'id = ?', whereArgs: [id]);
    return countOfDeleteRows > 0;
  }

  @override
  Future<List<Note>> read() async {
    List<Map<String, dynamic>> data = await database.query('notes');
    return data.map((rowMap) => Note.fromMap(rowMap)).toList();
  }
  // List<Note> notes = data.map((newMap) => Note.fromMap(newMap)).toList();

  @override
  Future<Note?> show(int id) async {
    List<Map<String, dynamic>> data =
        await database.query('notes', where: 'id = ?', whereArgs: [id]);
    if (data.isNotEmpty) {
      return Note.fromMap(data.first);
    }
    return null;
  }

  @override
  Future<bool> update(Note object) async {
    int countOfUpdatedRows = await database.update(
      'notes',
      object.toMap(),
      where: 'id = ?',
      whereArgs: [object.id],
    );
    return countOfUpdatedRows > 0;
  }
}
