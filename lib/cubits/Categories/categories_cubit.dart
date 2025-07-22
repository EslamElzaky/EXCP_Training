import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  static const String _key = 'categories_list';
  static const String _boxName = 'categoriesBox';
  CategoriesCubit() : super(CategoriesLoading()) {
    _loadCategories();
  }
  late Box _box;

  List<String> _categories = [];

  Future<void> _loadCategories() async {
     _box = Hive.box<List>(_boxName);
    _categories =
        (_box.get(_key)?.cast<String>()) ??
        ['sports', 'study', 'Games', 'work', 'others'];
    emit(CategoriesLoaded(List.from(_categories)));
  }

  Future<void> _saveCategories() async {
    await _box.put(_key, _categories);
  }

  void addCategory(String category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
      _saveCategories();
      emit(CategoriesLoaded(List.from(_categories)));
    }
  }

  void removeCategory(String category) {
    _categories.remove(category);
    _saveCategories();
    emit(CategoriesLoaded(List.from(_categories)));
  }
}
