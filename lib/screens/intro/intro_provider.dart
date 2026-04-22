import 'package:flutter/foundation.dart';

enum IntroLanguage { english, urdu }

class IntroProvider extends ChangeNotifier {
  IntroProvider._();

  static final IntroProvider instance = IntroProvider._();

  // ─── State ────────────────────────────────────────────────────────────────

  int _currentPage = 0;
  IntroLanguage _selectedLanguage = IntroLanguage.english;

  // ─── Getters ──────────────────────────────────────────────────────────────

  int get currentPage => _currentPage;
  IntroLanguage get selectedLanguage => _selectedLanguage;
  bool get isEnglishSelected => _selectedLanguage == IntroLanguage.english;
  bool get isFirstPage => _currentPage == 0;
  bool get isLastPage => _currentPage == totalPages - 1;

  // ─── Page count (total intro slides) ─────────────────────────────────────

  static const int totalPages = 5;

  // ─── Actions ──────────────────────────────────────────────────────────────

  void selectLanguage(IntroLanguage language) {
    if (_selectedLanguage == language) return;
    _selectedLanguage = language;
    notifyListeners();
  }

  void goToNextPage() {
    if (_currentPage < totalPages - 1) {
      _currentPage++;
      notifyListeners();
    }
  }

  void goToPreviousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      notifyListeners();
    }
  }

  void goToPage(int index) {
    assert(index >= 0 && index < totalPages, 'Page index out of range');
    if (_currentPage == index) return;
    _currentPage = index;
    notifyListeners();
  }
}
