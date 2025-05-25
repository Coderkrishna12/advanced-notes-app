import 'package:advanced_notes_app/locator.dart';
import 'package:advanced_notes_app/models/note.dart';
import 'package:advanced_notes_app/models/note_adapter.dart';
import 'package:advanced_notes_app/providers/notes_provider.dart';
import 'package:advanced_notes_app/router.dart';
import 'package:advanced_notes_app/services/notes_services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter()); // Register the adapter
  await Hive.openBox<Note>('notes');
  setupLocator(); // Initialize dependency injection
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title = 'Flutter Demo Home Page'});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    final note = Note(
      id: '$_counter',
      title: 'Test Note $_counter',
      content: 'This is a test note',
      category: 'General',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    notesProvider.addNote(note);
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.router.push(const HomeRoute()),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(name, args: '/');

  static const String name = 'HomeRoute';
}
