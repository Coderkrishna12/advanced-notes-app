import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../models/note.dart';
import '../router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  static var page;

  @override
  Widget build(BuildContext context) {
    final notesProvider = context.watch<NotesProvider>();
    final notes = notesProvider.notes;
    final isLoading = notesProvider.isLoading;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Notes'),
              background: Container(
                color: Colors.blue.withOpacity(0.7),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  context.router.push(AddEditNoteRoute(note: null));
                },
              ),
            ],
          ),
          if (isLoading)
            SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (notes.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  'Create your first note!',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final note = notes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.content.length > 50
                              ? '${note.content.substring(0, 50)}...'
                              : note.content,
                        ),
                        Text(
                          'Created: ${note.createdAt.toString().substring(0, 16)}',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          'Updated: ${note.updatedAt.toString().substring(0, 16)}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    trailing: Text(note.category ?? 'No Category'),
                    onTap: () {
                      context.router.push(NoteDetailRoute(note: note));
                    },
                  );
                },
                childCount: notes.length,
              ),
            ),
        ],
      ),
    );
  }
}

class AddEditNoteRoute extends PageRouteInfo {
  const AddEditNoteRoute({Note? note})
      : super(AddEditNoteRoute.name, args: note);
  static const String name = 'AddEditNoteRoute';
}

class NoteDetailRoute extends PageRouteInfo<NoteDetailRouteArgs> {
  NoteDetailRoute({required Note note})
      : super(NoteDetailRoute.name, args: NoteDetailRouteArgs(note: note));
  static const String name = 'NoteDetailRoute';
}

class NoteDetailRouteArgs {
  final Note note;
  const NoteDetailRouteArgs({required this.note});
}
