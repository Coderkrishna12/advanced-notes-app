import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
@HiveType(typeId: 0)
class Note with _$Note {
  const factory Note({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String content,
    @HiveField(3) String? category,
    @HiveField(4) required DateTime createdAt,
    @HiveField(5) required DateTime updatedAt,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
