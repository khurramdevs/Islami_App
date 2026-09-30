class Hadith {
  final int number;
  final String title;
  final String content;

  const Hadith({
    required this.number,
    required this.title,
    required this.content,
  });

  factory Hadith.fromApiJson(Map<String, dynamic> json) {
    final number = json['hadithnumber'] as int? ?? 0;
    return Hadith(
      number: number,
      title: 'الحديث ${_arabicOrdinal(number)}',
      content: json['text'] as String? ?? '',
    );
  }

  static String _arabicOrdinal(int n) {
    const ordinals = [
      'الأول',
      'الثاني',
      'الثالث',
      'الرابع',
      'الخامس',
      'السادس',
      'السابع',
      'الثامن',
      'التاسع',
      'العاشر',
      'الحادي عشر',
      'الثاني عشر',
      'الثالث عشر',
      'الرابع عشر',
      'الخامس عشر',
      'السادس عشر',
      'السابع عشر',
      'الثامن عشر',
      'التاسع عشر',
      'العشرون',
      'الحادي والعشرون',
      'الثاني والعشرون',
      'الثالث والعشرون',
      'الرابع والعشرون',
      'الخامس والعشرون',
      'السادس والعشرون',
      'السابع والعشرون',
      'الثامن والعشرون',
      'التاسع والعشرون',
      'الثلاثون',
      'الحادي والثلاثون',
      'الثاني والثلاثون',
      'الثالث والثلاثون',
      'الرابع والثلاثون',
      'الخامس والثلاثون',
      'السادس والثلاثون',
      'السابع والثلاثون',
      'الثامن والثلاثون',
      'التاسع والثلاثون',
      'الأربعون',
      'الحادي والأربعون',
      'الثاني والأربعون',
      'الثالث والأربعون',
      'الرابع والأربعون',
      'الخامس والأربعون',
      'السادس والأربعون',
      'السابع والأربعون',
      'الثامن والأربعون',
      'التاسع والأربعون',
      'الخمسون',
    ];
    if (n >= 1 && n <= ordinals.length) return ordinals[n - 1];
    return n.toString();
  }
}
