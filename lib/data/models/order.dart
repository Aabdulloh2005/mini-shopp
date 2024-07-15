import 'cart.dart';

class Order {
  final String id;
  final List<Cart> orders;

  const Order({required this.id, required this.orders});
}
