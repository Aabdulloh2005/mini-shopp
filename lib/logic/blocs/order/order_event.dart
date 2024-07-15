part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

final class AddOrderEvent extends OrderEvent {
  final Cart cart;

  AddOrderEvent({required this.cart});
}

final class GetOrdersEvent extends OrderEvent {}
