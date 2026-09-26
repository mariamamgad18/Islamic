class Azkar {
  final int id;
  final int count;

  final String text;
  final String? reference;

  Azkar({
    required this.id,
    required this.text,
    this.reference,
    required this.count,
  });
}
