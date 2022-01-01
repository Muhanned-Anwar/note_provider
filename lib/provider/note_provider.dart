import 'package:flutter/cupertino.dart';
import 'package:note_provider/controllers/note_db_controller.dart';
import 'package:note_provider/models/note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> notes = <Note>[];
  final NoteDbController _noteDbController = NoteDbController();

  Future<bool> create({required Note note}) async {
    int newRowId = await _noteDbController.create(note);
    if (newRowId != 0) {
      note.id = newRowId;
      notes.add(note);
      notifyListeners();
    }
    return newRowId != 0;
  }

  Future<void> read() async {
    notes = await _noteDbController.read();
    notifyListeners();
  }

  Future<void> show(int id) async {
    await _noteDbController.show(id);
    notifyListeners();
  }

  Future<bool> update({required Note note}) async {
    bool updated = await _noteDbController.update(note);
    if (updated) {
      int index = notes.indexWhere((element) => element.id == note.id);
      if (index != -1) {
        notes[index] = note;
        notifyListeners();
      }
    }
    return updated;
  }

  Future<bool> delete({required int id}) async {
    bool deleted = await _noteDbController.delete(id);
    if(deleted){
      notes.removeWhere((element) => element.id == id);
      notifyListeners();
    }
    return deleted;
}


}
