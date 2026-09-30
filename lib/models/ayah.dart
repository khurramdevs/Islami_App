class Ayah {
  final int number;
  final String text;

  const Ayah({required this.number, required this.text});

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['numberInSurah'] as int,
      text: (json['text'] as String).trim(),
    );
  }
}
