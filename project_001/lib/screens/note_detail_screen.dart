import 'package:advanced_notes_app/screens/home_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:advanced_notes_app/models/note.dart';
import 'package:advanced_notes_app/providers/notes_provider.dart';
import 'package:advanced_notes_app/router.dart' as app_router;

@RoutePage()
class NoteDetailScreen extends StatelessWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () =>
                context.router.push(app_router.AddEditNoteRoute(note: note)),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<NotesProvider>(context, listen: false)
                  .deleteNote(note.id);
              context.router.pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${note.title}',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Content: ${note.content}'),
            const SizedBox(height: 8),
            Text('Category: ${note.category ?? 'None'}'),
            const SizedBox(height: 8),
            Text('Created: ${note.createdAt}'),
            const SizedBox(height: 8),
            Text('Updated: ${note.updatedAt}'),
          ],
        ),
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}
