part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoadingState extends OrderState {}

final class OrderLoadedState extends OrderState {
  final Order orders;

  OrderLoadedState({required this.orders});
}

final class OrderErrorState extends OrderState {
  final String errorMessage;

  OrderErrorState({required this.errorMessage});
}
