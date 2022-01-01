import 'package:flutter/material.dart';
import 'package:note_provider/helpers/helpers.dart';
import 'package:note_provider/models/note.dart';
import 'package:note_provider/provider/note_provider.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> with Helpers {
  late TextEditingController _contentTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _contentTextController = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Add Note', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.black54,
              Colors.white70,
              Colors.white60,
              Colors.black54,
              Colors.black87,
              Colors.black54,
            ])),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            children: [
              TextField(
                controller: _contentTextController,
                decoration: InputDecoration(
                    hintText: 'Enter note content',
                    hintStyle: TextStyle(color: Colors.black54)),
                minLines: 1,
                maxLines: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  perFormSave();
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> perFormSave() async {
    if (checkData()) {
      await save();
    }
  }

  bool checkData() {
    if (_contentTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter required data', error: true);
    return false;
  }

  Future<void> save() async {
    bool created = await Provider.of<NoteProvider>(context,listen: false).create(note: note);
    String message = created ? 'Created successfully' : 'Created field';
    if(created)clear();
    showSnackBar(context: context, message: message);
  }

  Note get note {
    Note newNote = Note();
    newNote.content = _contentTextController.text;
    return newNote;
  }

  void clear(){
    _contentTextController.text = '';
  }
}
