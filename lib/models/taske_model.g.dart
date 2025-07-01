// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taske_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskeModelAdapter extends TypeAdapter<TaskeModel> {
  @override
  final int typeId = 0;

  @override
  TaskeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskeModel(
      typeTask: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      date: fields[3] as String,
      color: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TaskeModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.typeTask)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
