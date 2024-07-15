import 'product.dart';

class Cart {
  final String id;
  final List<Product> products;

  const Cart({
    required this.id,
    required this.products,
  });
}
