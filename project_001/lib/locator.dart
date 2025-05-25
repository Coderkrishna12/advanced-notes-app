import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:advanced_notes_app/models/note.dart';
import 'package:advanced_notes_app/services/notes_services.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingletonAsync<NotesService>(() async {
    final notesBox = Hive.box<Note>('notes');
    final service = HiveNotesService(notesBox);
    await service.init();
    return service;
  });
}
