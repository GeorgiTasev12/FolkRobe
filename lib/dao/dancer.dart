class Dancer {
  final int? id;
  final String name;
  final String gender;

  Dancer({
    this.id,
    required this.name,
    required this.gender,
  });

  factory Dancer.fromMap(Map<String, dynamic> map) {
    return Dancer(
      id: map['id'] as int?,
      name: map['name'] as String,
      gender: map['gender'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
    };
  }

  Dancer copyWith({
    int? id,
    String? name,
    String? gender,
  }) {
    return Dancer(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
    );
  }
}
