enum CategoryType {
  foodAndDrink,
  transportation,
  clothing,
  entertainment,
  dailyNeeds,
  health,
  education,
  others,
}

extension CategoryTypeExtension on CategoryType {
  String get displayName {
    switch (this) {
      case CategoryType.foodAndDrink:
        return "Makan & Minum";
      case CategoryType.transportation:
        return "Transportasi";
      case CategoryType.clothing:
        return "Pakaian";
      case CategoryType.entertainment:
        return "Hiburan";
      case CategoryType.health:
        return "Kesehatan";
      case CategoryType.education:
        return "Pendidikan";
      case CategoryType.others:
        return "Lainnya";
      case CategoryType.dailyNeeds:
        return "Kebutuhan Harian";
    }
  }
}
