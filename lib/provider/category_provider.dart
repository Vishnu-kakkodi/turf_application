import 'package:booking_application/modal/category_model.dart';
import 'package:booking_application/services/category_services.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  
  List<Category> _categories = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch categories from API
  Future<void> fetchCategories() async {
    _setLoading(true);
    _clearError();

    try {
      final CategoryResponse response = await _categoryService.getCategories();
      
      if (response.success) {
        _categories = response.categories;
      } else {
        _setError('Failed to fetch categories');
      }
    } catch (e) {
      _setError('Error: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Category? getCategoryById(String id) {
    try {
      return _categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }


  String getFullImageUrl(String imageUrl) {
    return _categoryService.getFullImageUrl(imageUrl);
  }


  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = '';
  }

  
  void clearCategories() {
    _categories.clear();
    _clearError();
    notifyListeners();
  }
}