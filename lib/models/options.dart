enum GenderType {
  male,
  female,
  none,
}

extension GenderNames on GenderType {
  String get genderName {
    switch (this) {
      case GenderType.male:
        return 'Мъж';
      case GenderType.female:
        return 'Жена';
      case GenderType.none:
        return 'Всички';
    }
  }
}

extension StringMapper on String {
  GenderType get asGenderType {
    switch (this) {
      case 'male':
        return GenderType.male;
      case 'female':
        return GenderType.female;
      case 'none':
        return GenderType.none;
      default:
        throw Exception('Invalid gender string: $this');
    }
  }
}

enum Options {
  shopska,
  trakiski,
  severniashka,
  rodopski,
  strandzhanski,
  dobrudzhanski,
  pirinski,
  none
}

extension OptionTableName on Options {
  String tableCostumeName(GenderType? gender) {
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
      case Options.none:
        return '';
    }
  }
}

extension OptionName on Options {
  String get optionName {
    switch (this) {
      case Options.shopska:
        return 'Шопска';
      case Options.trakiski:
        return 'Тракийска';
      case Options.severniashka:
        return 'Северняшка';
      case Options.rodopski:
        return 'Родопска';
      case Options.strandzhanski:
        return 'Странджанска';
      case Options.dobrudzhanski:
        return 'Добруджанска';
      case Options.pirinski:
        return 'Пиринска';
      case Options.none:
        return '';
    }
  }
}
