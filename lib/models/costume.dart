class Costumes {
  final List<Costume> costumes;

  const Costumes({
    this.costumes = const [],
  });
}

class Costume {
  int? id = 0;
  String title;

  Costume({
    this.id,
    required this.title,
  });
}