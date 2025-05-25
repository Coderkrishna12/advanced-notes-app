// TODO Implement this library.
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';

@RoutePage()
class AddEditNoteScreen extends StatelessWidget {
  final Note? note;

  AddEditNoteScreen({this.note});

  final form = FormGroup({
    'title': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(5),
        Validators.maxLength(100),
      ],
    ),
    'content': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(10),
      ],
    ),
    'category': FormControl<String>(),
  });

  static var page;

  @override
  Widget build(BuildContext context) {
    final notesProvider = context.read<NotesProvider>();

    // Pre-fill form if editing
    if (note != null) {
      form.control('title').value = note!.title;
      form.control('content').value = note!.content;
      form.control('category').value = note!.category;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'title',
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validationMessages: {
                        ValidationMessage.required: (_) => 'Title is required',
                        ValidationMessage.minLength: (_) =>
                            'Must be at least 5 characters',
                        ValidationMessage.maxLength: (_) =>
                            'Must not exceed 100 characters',
                      },
                    ),
                    SizedBox(height: 16),
                    ReactiveTextField<String>(
                      formControlName: 'content',
                      decoration: InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      validationMessages: {
                        ValidationMessage.required: (_) =>
                            'Content is required',
                        ValidationMessage.minLength: (_) =>
                            'Must be at least 10 characters',
                      },
                    ),
                    SizedBox(height: 16),
                    ReactiveDropdownField<String>(
                      formControlName: 'category',
                      decoration: InputDecoration(
                        labelText: 'Category (Optional)',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        DropdownMenuItem(value: null, child: Text('None')),
                        DropdownMenuItem(value: 'Work', child: Text('Work')),
                        DropdownMenuItem(
                            value: 'Personal', child: Text('Personal')),
                        DropdownMenuItem(value: 'Ideas', child: Text('Ideas')),
                        DropdownMenuItem(
                            value: 'Archive', child: Text('Archive')),
                      ],
                    ),
                    SizedBox(height: 16),
                    ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return ElevatedButton(
                          onPressed: form.valid
                              ? () async {
                                  try {
                                    final newNote = Note(
                                      id: note?.id ?? Uuid().v4(),
                                      title: form.control('title').value!,
                                      content: form.control('content').value!,
                                      category: form.control('category').value,
                                      createdAt:
                                          note?.createdAt ?? DateTime.now(),
                                      updatedAt: DateTime.now(),
                                    );
                                    if (note == null) {
                                      await notesProvider.addNote(newNote);
                                    } else {
                                      await notesProvider.updateNote(newNote);
                                    }
                                    context.router.pop();
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error: $e')),
                                    );
                                  }
                                }
                              : null,
                          child: Text('Save'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on StackRouter {
  void pop() {}
}
