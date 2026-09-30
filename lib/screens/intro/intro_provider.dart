import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum IntroLanguage { english, urdu }

class IntroProvider extends ChangeNotifier {
  IntroProvider._();

  static final IntroProvider instance = IntroProvider._();

  static const String _kOnboardingDoneKey = 'onboarding_done';

  // State
  int _currentPage = 0;
  IntroLanguage _selectedLanguage = IntroLanguage.english;
  bool _onboardingDone = false;

  // Getters
  int get currentPage => _currentPage;
  IntroLanguage get selectedLanguage => _selectedLanguage;
  bool get isEnglishSelected => _selectedLanguage == IntroLanguage.english;
  bool get isFirstPage => _currentPage == 0;
  bool get isLastPage => _currentPage == totalPages - 1;
  bool get onboardingDone => _onboardingDone;

  // Page count (total intro slides)
  static const int totalPages = 5;

  /// Reads the persisted onboarding flag. Call once at startup (from Splash).
  Future<bool> checkOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    _onboardingDone = prefs.getBool(_kOnboardingDoneKey) ?? false;
    return _onboardingDone;
  }

  /// Persists the onboarding-completed flag. Call when user taps Finish.
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardingDoneKey, true);
    _onboardingDone = true;
  }

  // Actions

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
