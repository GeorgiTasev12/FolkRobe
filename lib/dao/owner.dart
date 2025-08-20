class Owner {
  final int? id;
  final String title;
  final String name;
  final String items;

  Owner({
    required this.title,
    required this.name,
    required this.items,
    this.id,
  });

  Owner copyWith({
    int? id,
    String? title,
    String? name,
    String? items,
  }) {
    return Owner(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      id: map['id'] as int?,
      title: map['title'] as String,
      name: map['name'] as String,
      items: (map['items'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'items': items,
    };
  }
}
