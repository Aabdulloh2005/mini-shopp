part of 'cart_bloc.dart';

sealed class CartEvents {}

final class AddProductToCartEvent extends CartEvents {
  final Product product;

  AddProductToCartEvent({required this.product});
}

final class DeleteProductFromCartEvent extends CartEvents {
  final String id;

  DeleteProductFromCartEvent({required this.id});
}

final class MakeOrderEvent extends CartEvents {}
