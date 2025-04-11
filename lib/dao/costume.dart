class Costume {
  final int? id;
  final String title;

  Costume({
    this.id,
    required this.title,
  });

  factory Costume.fromMap(Map<String, dynamic> map) {
    return Costume(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  Costume copyWith({
    int? id,
    String? title,
  }) {
    return Costume(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
