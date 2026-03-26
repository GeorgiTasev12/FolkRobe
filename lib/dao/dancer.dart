class Dancer {
  final int? id;
  final String name;
  final String gender;
  final String ageGroup;

  Dancer({
    this.id,
    required this.name,
    required this.gender,
    required this.ageGroup,
  });

  factory Dancer.fromMap(Map<String, dynamic> map) {
    return Dancer(
      id: map['id'] as int?,
      name: map['name'] as String,
      gender: map['gender'] as String,
      ageGroup: map['ageGroup'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'ageGroup': ageGroup,
    };
  }

  Dancer copyWith({
    int? id,
    String? name,
    String? gender,
    String? ageGroup,
  }) {
    return Dancer(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
    );
  }
}
