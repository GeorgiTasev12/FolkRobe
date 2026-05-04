class Owner {
  final int? id;
  final String title;
  final String name;
  final String items;
  final String gender;
  final String ageGroup;

  Owner({
    required this.title,
    required this.name,
    required this.items,
    required this.gender,
    required this.ageGroup,
    this.id,
  });

  Owner copyWith({
    int? id,
    String? title,
    String? name,
    String? items,
    String? gender,
    String? ageGroup,
  }) {
    return Owner(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      items: items ?? this.items,
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
    );
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      id: map['id'] as int?,
      title: map['title'] as String,
      name: map['name'] as String,
      gender: map['gender'] as String,
      items: (map['items'] as String?) ?? '',
      ageGroup: map['ageGroup'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'name': name,
      'gender': gender,
      'items': items,
      'ageGroup': ageGroup,
    };
  }
}
