// TODO Implement this library.
import 'package:advanced_notes_app/screens/homescreen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';
import '../router.dart';

@RoutePage()
class NoteDetailScreen extends StatelessWidget {
  final Note note;

  static var page;

  NoteDetailScreen({required this.note});

  @override
  Widget build(BuildContext context) {
    final notesProvider = context.read<NotesProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              context.router.push(AddEditNoteRoute(note: note));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Note'),
                  content: Text('Are you sure you want to delete this note?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                try {
                  await notesProvider.deleteNote(note.id);
                  context.router.pop();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting note: $e')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ${note.title}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Category: ${note.category ?? 'None'}'),
                  SizedBox(height: 8),
                  Text('Content:'),
                  Text(note.content),
                  SizedBox(height: 8),
                  Text(
                      'Created: ${note.createdAt.toString().substring(0, 16)}'),
                  SizedBox(height: 8),
                  Text(
                      'Updated: ${note.updatedAt.toString().substring(0, 16)}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}
