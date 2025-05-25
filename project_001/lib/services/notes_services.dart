import 'package:hive/hive.dart';
import 'package:advanced_notes_app/models/note.dart';

abstract class NotesService {
  Future<void> init();
  List<Note> getAllNotes();
  void addNote(Note note);
  void updateNote(Note note);
  void deleteNote(String id);
}

class HiveNotesService implements NotesService {
  final Box<Note> _notesBox;

  HiveNotesService(this._notesBox);

  @override
  Future<void> init() async {
    // Perform any initialization if needed
    // For Hive, the box is already opened in main.dart, so this can be empty
    // Add any additional setup logic here if required
  }

  @override
  List<Note> getAllNotes() => _notesBox.values.toList();

  @override
  void addNote(Note note) {
    _notesBox.put(note.id, note);
  }

  @override
  void updateNote(Note note) {
    _notesBox.put(note.id, note);
  }

  @override
  void deleteNote(String id) {
    _notesBox.delete(id);
  }
}
