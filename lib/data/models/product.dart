class Product {
  final String id;
  String title;
  String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.isFavorite = false,
  });
}
