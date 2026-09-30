import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:islami/models/hadith.dart';
import 'package:islami/models/reciter.dart';
import 'package:islami/models/radio.dart';
import 'package:islami/models/prayer_times.dart';
import 'package:islami/models/ayah.dart';

class ApiService {
  ApiService._();

  static Future<List<Reciter>> fetchReciters() async {
    final response = await http.get(
      Uri.parse('https://www.mp3quran.net/api/v3/reciters?language=ar'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data['reciters'] as List<dynamic>;
      return list
          .map((e) => Reciter.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load reciters');
  }

  static Future<List<QuranRadio>> fetchRadios() async {
    final response = await http.get(
      Uri.parse('https://mp3quran.net/api/v3/radios?language=ar'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data['radios'] as List<dynamic>;
      return list
          .map((e) => QuranRadio.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load radios');
  }

  static Future<PrayerTimes> fetchPrayerTimes({
    String city = 'cairo',
    String country = 'egypt',
  }) async {
    final now = DateTime.now();
    final date =
        '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
    final response = await http.get(
      Uri.parse(
        'https://api.aladhan.com/v1/timingsByCity/$date?city=$city&country=$country',
      ),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return PrayerTimes.fromJson(data);
    }
    throw Exception('Failed to load prayer times');
  }

  static Future<List<Ayah>> fetchAyahs(int surahNumber) async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/surah/$surahNumber'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data['data']['ayahs'] as List<dynamic>;
      return list.map((e) => Ayah.fromJson(e as Map<String, dynamic>)).toList();
    }
    throw Exception('Failed to load ayahs');
  }

  static Future<List<Hadith>> fetchHadiths() async {
    final response = await http.get(
      Uri.parse(
        'https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/ara-nawawi.json',
      ),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final list = data['hadiths'] as List<dynamic>;
      return list
          .map((e) => Hadith.fromApiJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Failed to load hadiths');
  }
}
