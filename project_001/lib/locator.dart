import 'package:get_it/get_it.dart';
import 'package:advanced_notes_app/services/notes_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingletonAsync<NotesService>(() async {
    final service = NotesService();
    await service.init();
    return service;
  });
}
