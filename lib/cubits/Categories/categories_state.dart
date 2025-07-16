part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<String> categories;
  CategoriesLoaded(this.categories);
}

