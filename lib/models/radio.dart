class QuranRadio {
  final int id;
  final String name;
  final String url;

  QuranRadio({required this.id, required this.name, required this.url});

  factory QuranRadio.fromJson(Map<String, dynamic> json) {
    return QuranRadio(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
