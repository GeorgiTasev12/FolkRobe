enum Options {
  shopski,
  trakiski,
  severniashka,
  rodopski,
  strandzhanski,
  dobrudzhanski,
  pirinski
}

extension OptionTableName on Options {
  String get tableName {
    switch (this) {
      case Options.shopski:
        return 'costume_shopska';
      case Options.trakiski:
        return 'costume_trakiski';
      case Options.severniashka:
        return 'costume_severniashka';
      case Options.rodopski:
        return 'costume_rodopski';
      case Options.strandzhanski:
        return 'costume_strandzhanski';
      case Options.dobrudzhanski:
        return 'costume_dobrudzhanski';
      case Options.pirinski:
        return 'costume_pirinski';
    }
  }
}

extension OptionName on Options {
  String get optionName {
    switch (this) {
      case Options.shopski:
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
