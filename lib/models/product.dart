class Product {
  final int id; // Почему на Api id это str хотели uuid?????
  final String image;
  final String name;
  final Rating rating;
  final int priceCents;
  final String category;
  final String subCategory;
  final List<String> keywords;
  final String description;

  const Product({
    required this.id,
    required this.image,
    required this.name,
    required this.rating,
    required this.priceCents,
    required this.category,
    required this.subCategory,
    required this.keywords,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['id']),
      image: json['image'] as String,
      name: json['name'],
      rating: Rating.fromJson(json['rating']),
      priceCents: json['priceCents'],
      category: json['category'],
      subCategory: json['subCategory'],
      keywords: List<String>.from(json['keywords']),
      description: json['description'],
    );
  }

  // для теста, чтобы проверить правильность парса
  @override
  String toString() {
    return 'Product(id: $id, name: $name, priceCents: $priceCents, category: $category, rating: $rating)';
  }
}

class Rating {
  final double stars;
  final int count;

  const Rating({required this.stars, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(stars: json['stars'], count: json['count']);
  }

  @override
  String toString() {
    return 'Rating(starts: $stars, count: $count)';
  }
}

