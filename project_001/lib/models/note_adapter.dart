import 'package:hive/hive.dart';
import 'note.dart';

part 'note_adapter.g.dart';

@HiveType(typeId: 0)
class NoteAdapter implements Note {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final String? category;
  @HiveField(4)
  final DateTime createdAt;
  @HiveField(5)
  final DateTime updatedAt;

  NoteAdapter({
    required this.id,
    required this.title,
    required this.content,
    this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  // TODO: implement copyWith
  $NoteCopyWith<Note> get copyWith => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
