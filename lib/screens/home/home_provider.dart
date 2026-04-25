import 'package:flutter/material.dart';
import 'package:islami/core/api_service.dart';
import 'package:islami/models/sura.dart';
import 'package:islami/models/reciter.dart';
import 'package:islami/models/radio.dart';
import 'package:islami/models/prayer_times.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider._();
  static final HomeProvider instance = HomeProvider._();

  int _currentTab = 0;
  int get currentTab => _currentTab;
  void setTab(int index) {
    _currentTab = index;
    notifyListeners();
  }

  // Sura list
  List<Sura> get suras => Sura.allSuras;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  List<Sura> get filteredSuras {
    if (_searchQuery.isEmpty) return suras;
    final q = _searchQuery.toLowerCase();
    return suras
        .where(
          (s) =>
              s.nameEn.toLowerCase().contains(q) ||
              s.nameAr.contains(_searchQuery),
        )
        .toList();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Sura> get recentSuras => [
    suras[20], // Al-Anbiya
    suras[0], // Al-Fatiha
  ];

  // API data
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Reciter> _reciters = [];
  List<Reciter> get reciters => _reciters;

  List<QuranRadio> _radios = [];
  List<QuranRadio> get radios => _radios;

  PrayerTimes? _prayerTimes;
  PrayerTimes? get prayerTimes => _prayerTimes;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        ApiService.fetchReciters(),
        ApiService.fetchRadios(),
        ApiService.fetchPrayerTimes(),
      ]);
      _reciters = results[0] as List<Reciter>;
      _radios = results[1] as List<QuranRadio>;
      _prayerTimes = results[2] as PrayerTimes;
    } catch (e) {
      debugPrint('API error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
