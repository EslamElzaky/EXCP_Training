part of 'task_cubit_cubit.dart';

@immutable
sealed class TaskCubitState {}

final class TaskCubitInitial extends TaskCubitState {}

final class TaskCubitLoding extends TaskCubitState {}


final class TaskCubitSuccess extends TaskCubitState {}

final class TaskCubitFiluer extends TaskCubitState {
  final String errorMessage;
  TaskCubitFiluer(this.errorMessage);
}
