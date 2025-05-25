import 'package:advanced_notes_app/locator.dart';
import 'package:advanced_notes_app/models/note.dart' hide NoteAdapter;
import 'package:advanced_notes_app/models/note_adapter.dart';
import 'package:advanced_notes_app/providers/notes_provider.dart';
import 'package:advanced_notes_app/router.dart';
import 'package:advanced_notes_app/services/notes_services.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotesProvider(locator<NotesService>()),
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
