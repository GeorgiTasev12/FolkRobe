class Costume {
  final int? id;
  final int? quantity;
  final String title;

  Costume({
    required this.title,
    this.id,
    this.quantity,
  });

  factory Costume.fromMap(Map<String, dynamic> map) {
    return Costume(
      id: map['id'] as int,
      quantity: map['quantity'],
      title: map['title'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
    };
  }

  Costume copyWith({
    int? id,
    int? quantity,
    String? title,
  }) {
    return Costume(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      title: title ?? this.title,
    );
  }
}
