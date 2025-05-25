// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteAdapterAdapter extends TypeAdapter<NoteAdapter> {
  @override
  final int typeId = 0;

  @override
  NoteAdapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteAdapter(
        id: '',
        content: '',
        updatedAt: DateTime.now(),
        title: '',
        createdAt: DateTime.now());
  }

  @override
  void write(BinaryWriter writer, NoteAdapter obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
