part of 'cart_bloc.dart';

sealed class CartState {}

final class InitialCartState extends CartState {}

final class LoadingCartState extends CartState {}

final class LoadedCartState extends CartState {
  final Cart cart;

  LoadedCartState({required this.cart});
}

final class ErrorCartState extends CartState {
  final String errorMessage;

  ErrorCartState({required this.errorMessage});
}
