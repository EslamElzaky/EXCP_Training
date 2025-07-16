import 'package:bloc/bloc.dart';
import 'package:excp_training/constant.dart';
import 'package:excp_training/models/taske_model.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'read_task_state.dart';

class ReadTaskCubit extends Cubit<ReadTaskState> {
  ReadTaskCubit() : super(ReadTaskInitial());
  List<TaskeModel>? taske;
  fetchAllTaske() async {
    var taskBox = Hive.box<TaskeModel>(kTaskesBox);
    taske = taskBox.values.toList();
    taske!.sort((a, b) {
      DateTime dateA = DateFormat('yyyy-MM-dd hh:mm a').parse(a.date);
      DateTime dateB = DateFormat('yyyy-MM-dd hh:mm a').parse(b.date);
      return dateB.compareTo(dateA); // الأحدث أولاً
    });

    emit(ReadTaskSuccess(taske!));
  }
}
