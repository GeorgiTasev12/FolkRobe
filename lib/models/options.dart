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
  other,
  none
}

extension OptionTableName on Options {
  String tableCostumeName(
    GenderType? gender,
    AgeGroup? age,
  ) {
    final genderPrefix = gender == GenderType.female ? 'female' : 'male';
    final agePrefix = age == AgeGroup.adult ? 'adult' : 'child';

    switch (this) {
      case Options.shopska:
        return '${agePrefix}_${genderPrefix}_costume_shopska';
      case Options.trakiski:
        return '${agePrefix}_${genderPrefix}_costume_trakiski';
      case Options.severniashka:
        return '${agePrefix}_${genderPrefix}_costume_severniashka';
      case Options.rodopski:
        return '${agePrefix}_${genderPrefix}_costume_rodopski';
      case Options.strandzhanski:
        return '${agePrefix}_${genderPrefix}_costume_strandzhanski';
      case Options.dobrudzhanski:
        return '${agePrefix}_${genderPrefix}_costume_dobrudzhanski';
      case Options.pirinski:
        return '${agePrefix}_${genderPrefix}_costume_pirinski';
      case Options.other:
        return '${agePrefix}_${Options.other.name}_costume';
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
      case Options.other:
        return 'Други';
      case Options.none:
        return '';
    }
  }
}

enum AgeGroup {
  adult,
  child,
  none,
}

extension AgeGroupName on AgeGroup {
  String get agesName {
    switch (this) {
      case AgeGroup.adult:
        return 'Възрастни';
      case AgeGroup.child:
        return 'Деца';
      case AgeGroup.none:
        return '';
    }
  }
}

enum PageSource {
  costumes,
  dancers,
}
