import 'package:advanced_notes_app/screens/home_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:advanced_notes_app/main.dart';
import 'package:advanced_notes_app/screens/add_edit_note_screen.dart';
import 'package:advanced_notes_app/screens/home_screen.dart';
import 'package:advanced_notes_app/screens/note_detail_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MyHomePageRoute.page,
          path: '/my-home',
          title: (context, data) => 'Flutter Demo Home Page',
        ),
        AutoRoute(
          page: HomeScreen.page,
          initial: true,
          path: '/',
          title: (context, data) => 'Home',
        ),
        AutoRoute(
          page: AddEditNoteRoute.page,
          path: '/add-edit-note',
          title: (context, data) => 'Add/Edit Note',
        ),
        AutoRoute(
          page: NoteDetailRoute.page,
          path: '/note-detail',
          title: (context, data) => 'Note Detail',
        ),
      ];
}

class MyHomePageRoute {
  static var page;
}
