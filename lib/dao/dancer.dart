class Dancer {
  final int? id;
  final String name;

  Dancer({this.id, required this.name});

  factory Dancer.fromMap(Map<String, dynamic> map) {
    return Dancer(
      id: map['id'] as int?,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  Dancer copyWith({
    int? id,
    String? name,
  }) {
    return Dancer(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
