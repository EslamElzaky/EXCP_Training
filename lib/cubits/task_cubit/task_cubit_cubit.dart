import 'package:bloc/bloc.dart';
import 'package:excp_training/constant.dart';
import 'package:excp_training/models/taske_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'task_cubit_state.dart';

class TaskCubitCubit extends Cubit<TaskCubitState> {
  TaskCubitCubit() : super(TaskCubitInitial());

  addTask(TaskeModel task) async {
    emit(TaskCubitLoding());
    try {
      var taskBox = Hive.box<TaskeModel>(kTaskesBox);
      await taskBox.add(task);
      emit(TaskCubitSuccess());

      
    } on Exception catch (e) {
      emit(TaskCubitFiluer(e.toString()));
    }
  }
}
