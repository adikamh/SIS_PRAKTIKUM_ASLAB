class Drink {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final String category;
  final String description;
  final double rating;
  final String compatibleModels;

  Drink({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.category = 'Silicone',
    this.description =
        'Casing pelindung premium dengan material berkualitas tinggi, tahan benturan (shockproof), anti gores, dan nyaman digenggam.',
    this.rating = 4.9,
    this.compatibleModels = 'iPhone / Samsung / Xiaomi / Oppo',
  });

  Drink copyWith({
    String? id,
    String? name,
    int? price,
    String? imageUrl,
    String? category,
    String? description,
    double? rating,
    String? compatibleModels,
  }) {
    return Drink(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      compatibleModels: compatibleModels ?? this.compatibleModels,
    );
  }
}

// Alias for convenience
typedef Product = Drink;
