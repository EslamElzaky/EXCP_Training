import 'package:hive/hive.dart';

part 'taske_model.g.dart';

@HiveType(typeId: 0)

class TaskeModel extends HiveObject {
  @HiveField(0)
   String typeTask;
  @HiveField(1)
   String title;
  @HiveField(2)
   String content;
  @HiveField(3)
  String date;
  @HiveField(4)
   bool isNew;
 

  TaskeModel( {this.isNew = true,
    required this.typeTask,
    required this.title,
    required this.content,
    required this.date,
    
  });
}
