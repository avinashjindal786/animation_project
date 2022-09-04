

import 'dart:ui';

class Recipe {
  final int id;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;

  final String bgImageName;


  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,

    required this.bgImageName,

  });
}
