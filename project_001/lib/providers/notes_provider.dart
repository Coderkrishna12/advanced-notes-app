import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../services/notes_services.dart';

class NotesProvider with ChangeNotifier {
  final NotesService _notesService;
  List<Note> _notes = [];
  bool _isLoading = false;

  NotesProvider(this._notesService) {
    loadNotes();
  }

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;

  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners();
    _notes = await _notesService.getAllNotes();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _notesService.addNote(note);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    await _notesService.updateNote(note);
    await loadNotes();
  }

  Future<void> deleteNote(String id) async {
    await _notesService.deleteNote(id);
    await loadNotes();
  }
}
