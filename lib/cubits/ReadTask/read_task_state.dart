part of 'read_task_cubit.dart';

@immutable
sealed class ReadTaskState {}

final class ReadTaskInitial extends ReadTaskState {}

final class ReadTaskLoding extends ReadTaskState {}

final class ReadTaskSuccess extends ReadTaskState {
  final List<TaskeModel> taske;

  ReadTaskSuccess(this.taske);

  
}


