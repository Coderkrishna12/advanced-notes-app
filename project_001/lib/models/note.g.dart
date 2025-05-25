// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteImpl _$$NoteImplFromJson(Map<String, dynamic> json) => NoteImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

class NoteImpl {
  final String id;
  final String title;
  final String content;
  final String? category;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteImpl({
    required this.id,
    required this.title,
    required this.content,
    this.category,
    required this.createdAt,
    required this.updatedAt,
  });
}

Map<String, dynamic> _$$NoteImplToJson(NoteImpl instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
