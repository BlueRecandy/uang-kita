import 'package:flutter/material.dart';

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
  Icon get icon {
    switch (this) {
      case CategoryType.foodAndDrink:
        return const Icon(Icons.fastfood);
      case CategoryType.transportation:
        return const Icon(Icons.directions_car);
      case CategoryType.clothing:
        return const Icon(Icons.shopping_bag);
      case CategoryType.entertainment:
        return const Icon(Icons.movie);
      case CategoryType.health:
        return const Icon(Icons.local_hospital);
      case CategoryType.education:
        return const Icon(Icons.school);
      case CategoryType.others:
        return const Icon(Icons.more_horiz);
      case CategoryType.dailyNeeds:
        return const Icon(Icons.shopping_cart);
    }
  }

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

// map string to CategoryType
final categoryTypeMap = {
  'foodAndDrink': CategoryType.foodAndDrink,
  'transportation': CategoryType.transportation,
  'clothing': CategoryType.clothing,
  'entertainment': CategoryType.entertainment,
  'dailyNeeds': CategoryType.dailyNeeds,
  'health': CategoryType.health,
  'education': CategoryType.education,
  'others': CategoryType.others,
};

class CategoryTypeModel {
  final CategoryType type;
  final Icon icon;

  CategoryTypeModel({
    required this.type,
    required this.icon,
  });
}
