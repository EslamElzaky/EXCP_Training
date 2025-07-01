import 'package:hive/hive.dart';

part 'taske_model.g.dart';

@HiveType(typeId: 0)

class TaskeModel extends HiveObject {
  @HiveField(0)
  final String typeTask;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final int color;

  TaskeModel({
    required this.typeTask,
    required this.title,
    required this.content,
    required this.date,
    required this.color,
  });
}
