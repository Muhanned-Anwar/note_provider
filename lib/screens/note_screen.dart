import 'package:flutter/material.dart';
import 'package:note_provider/helpers/helpers.dart';
import 'package:note_provider/models/note.dart';
import 'package:note_provider/provider/note_provider.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with Helpers {
  int? index;
  int? id;

  late TextEditingController _updateTextEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _updateTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ModalRoute? modalRoute = ModalRoute.of(context);

    if (modalRoute != null && modalRoute.settings.arguments != null) {
      int? index = modalRoute.settings.arguments as int?;
      this.index = index;
    }
    return Consumer<NoteProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Note'),
            centerTitle: true,
            actions: [IconButton(onPressed: () async {
              id = value.notes[index!].id;
              bool updated = await updateNote();
              String message = updated
                  ? 'Updated successfully'
                  : 'Updated field';
              showSnackBar(context: context, message: message, error: !updated);
            }, icon: Icon(Icons.save))
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            height: double.infinity,
            padding: EdgeInsets.only(top: 70.0, right: 20, left: 20),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.black54,
                  Colors.black,
                ])),
            child: TextField(
              controller: _updateTextEditingController
                ..text = value.notes[index!].content,
              style: TextStyle(color: Colors.white),
              minLines: 1,
              maxLines: 50,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> updateNote() async {
    Note note = Note();
    note.content = _updateTextEditingController.text;
    note.id = id!;
    bool updated = await Provider.of<NoteProvider>(context, listen: false)
        .update(note: note);
    return updated;
  }
}
