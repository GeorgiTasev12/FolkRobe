enum GenderType {
  male,
  female,
}

enum Options {
  shopska,
  trakiski,
  severniashka,
  rodopski,
  strandzhanski,
  dobrudzhanski,
  pirinski
}

extension OptionTableName on Options {
  String tableCostumeName(GenderType gender) {
    final prefix = gender == GenderType.female ? 'female_' : 'male_';

    switch (this) {
      case Options.shopska:
        return '${prefix}costume_shopska';
      case Options.trakiski:
        return '${prefix}costume_trakiski';
      case Options.severniashka:
        return '${prefix}costume_severniashka';
      case Options.rodopski:
        return '${prefix}costume_rodopski';
      case Options.strandzhanski:
        return '${prefix}costume_strandzhanski';
      case Options.dobrudzhanski:
        return '${prefix}costume_dobrudzhanski';
      case Options.pirinski:
        return '${prefix}costume_pirinski';
    }
  }
}

String tableDancerName(GenderType gender) {
  final prefix = gender == GenderType.female ? 'female' : 'male';
  return '${prefix}_dancer';
}

String tableOwnersName(GenderType gender) {
  final prefix = gender == GenderType.female ? 'female' : 'male';
  return '${prefix}_owner';
}

extension OptionName on Options {
  String get optionName {
    switch (this) {
      case Options.shopska:
        return 'Шопски';
      case Options.trakiski:
        return 'Тракийски';
      case Options.severniashka:
        return 'Северняшки';
      case Options.rodopski:
        return 'Родопски';
      case Options.strandzhanski:
        return 'Странджански';
      case Options.dobrudzhanski:
        return 'Добруджански';
      case Options.pirinski:
        return 'Пирински';
    }
  }
}
