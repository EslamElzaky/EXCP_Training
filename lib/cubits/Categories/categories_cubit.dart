import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  static const String _storageKey = 'categories_list';

  CategoriesCubit() : super(CategoriesLoading()) {
    _loadCategories();
  }

  List<String> _categories = [];

  Future<void> _loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    _categories = prefs.getStringList(_storageKey) ?? [
      'sports', 'study', 'Games', 'work', 'others'
    ];
    emit(CategoriesLoaded(List.from(_categories)));
  }

  Future<void> _saveCategories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, _categories);
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
