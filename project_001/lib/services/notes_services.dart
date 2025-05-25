import 'package:hive/hive.dart';
import '../models/note.dart';
import 'package:uuid/uuid.dart';

class NotesService {
  static const String boxName = 'notes';
  late Box<Note> _box;

  Future<void> init() async {
    _box = await Hive.openBox<Note>(boxName);
  }

  Future<List<Note>> getAllNotes() async {
    return _box.values.toList();
  }

  Future<void> addNote(Note note) async {
    await _box.put(note.id, note);
  }

  Future<void> updateNote(Note note) async {
    await _box.put(note.id, note);
  }

  Future<void> deleteNote(String id) async {
    await _box.delete(id);
  }
}
