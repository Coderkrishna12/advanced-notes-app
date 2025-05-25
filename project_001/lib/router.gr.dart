// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AddEditNoteScreen]
class AddEditNoteRoute extends PageRouteInfo<AddEditNoteRouteArgs> {
  AddEditNoteRoute({
    Note? note,
    List<PageRouteInfo>? children,
  }) : super(
          AddEditNoteRoute.name,
          args: AddEditNoteRouteArgs(note: note),
          initialChildren: children,
        );

  static const String name = 'AddEditNoteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddEditNoteRouteArgs>(
          orElse: () => const AddEditNoteRouteArgs());
      return AddEditNoteScreen(note: args.note);
    },
  );
}

class AddEditNoteRouteArgs {
  const AddEditNoteRouteArgs({this.note});

  final Note? note;

  @override
  String toString() {
    return 'AddEditNoteRouteArgs{note: $note}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return HomeScreen();
    },
  );
}

/// generated route for
/// [NoteDetailScreen]
class NoteDetailRoute extends PageRouteInfo<NoteDetailRouteArgs> {
  NoteDetailRoute({
    Key? key,
    required Note note,
    List<PageRouteInfo>? children,
  }) : super(
          NoteDetailRoute.name,
          args: NoteDetailRouteArgs(
            key: key,
            note: note,
          ),
          initialChildren: children,
        );

  static const String name = 'NoteDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NoteDetailRouteArgs>();
      return NoteDetailScreen(
        key: args.key,
        note: args.note,
      );
    },
  );
}

class NoteDetailRouteArgs {
  const NoteDetailRouteArgs({
    this.key,
    required this.note,
  });

  final Key? key;

  final Note note;

  @override
  String toString() {
    return 'NoteDetailRouteArgs{key: $key, note: $note}';
  }
}
