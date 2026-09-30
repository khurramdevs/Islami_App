import 'package:flutter/material.dart';
import 'package:islami/const/app_assets.dart';
import 'package:islami/const/app_colors.dart';
import 'package:islami/core/api_service.dart';
import 'package:islami/models/ayah.dart';
import 'package:islami/models/sura.dart';

class SurahDetailScreen extends StatefulWidget {
  final Sura sura;

  const SurahDetailScreen({super.key, required this.sura});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  int? _selectedAyah;
  List<Ayah> _ayahs = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAyahs();
  }

  Future<void> _loadAyahs() async {
    try {
      final ayahs = await ApiService.fetchAyahs(widget.sura.number);
      setState(() {
        _ayahs = ayahs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // App bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.gold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.sura.nameEn,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Decorative borders + Arabic name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppAssets.borderL,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        widget.sura.nameAr,
                        style: const TextStyle(
                          color: AppColors.gold,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        AppAssets.borderR,
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Content
                Expanded(child: _buildContent()),
                const SizedBox(height: 8),
              ],
            ),
            // Bottom image
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Image.asset(AppAssets.bottom, fit: BoxFit.fitWidth),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.gold),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: AppColors.gold, size: 48),
            const SizedBox(height: 12),
            Text(
              'Failed to load ayahs',
              style: TextStyle(
                color: AppColors.white.withValues(alpha: 0.7),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _error = null;
                });
                _loadAyahs();
              },
              child: const Text(
                'Retry',
                style: TextStyle(color: AppColors.gold, fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _ayahs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final ayah = _ayahs[index];
        final isSelected = _selectedAyah == ayah.number;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedAyah = ayah.number;
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.gold : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gold, width: 1.5),
            ),
            child: Text(
              '${ayah.text} [${ayah.number}]',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? AppColors.black : AppColors.gold,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.6,
              ),
            ),
          ),
        );
      },
    );
  }
}
