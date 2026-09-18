class Costume {
  final int? id;
  final int? quantity;
  final String title;
  final int? itemCheck;

  Costume({
    required this.title,
    this.id,
    this.quantity,
    this.itemCheck = 0,
  });

  factory Costume.fromMap(Map<String, dynamic> map) {
    return Costume(
      id: map['id'] as int,
      quantity: map['quantity'],
      title: map['title'] as String,
      itemCheck: map['itemCheck'] as int
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'itemCheck': itemCheck,
    };
  }

  Costume copyWith({
    int? id,
    int? quantity,
    String? title,
    int? itemCheck,
  }) {
    return Costume(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      title: title ?? this.title,
      itemCheck: itemCheck ?? this.itemCheck,
    );
  }
}
