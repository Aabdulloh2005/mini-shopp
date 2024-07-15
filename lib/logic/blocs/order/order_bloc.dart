import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:very_simple_online_shop_cubit/data/models/cart.dart';
import 'package:very_simple_online_shop_cubit/data/models/order.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<AddOrderEvent>(_addOrderEvent);
    on<GetOrdersEvent>(_getOrdersEvent);
  }

  final Order _order = Order(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    orders: [],
  );

  void _addOrderEvent(AddOrderEvent event, Emitter<OrderState> emit) {
    try {
      emit(OrderLoadingState());
      _order.orders.add(event.cart);
      emit(OrderLoadedState(orders: _order));
    } catch (e) {
      emit(OrderErrorState(errorMessage: e.toString()));
    }
  }

  void _getOrdersEvent(GetOrdersEvent event, Emitter<OrderState> emit) {
    try {
      emit(OrderLoadingState());
      // getting orders from database or somewhere
      emit(OrderLoadedState(orders: _order));
    } catch (e) {
      emit(OrderErrorState(errorMessage: e.toString()));
    }
  }
}
