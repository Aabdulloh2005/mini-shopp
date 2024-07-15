import 'package:bloc/bloc.dart';
import 'package:very_simple_online_shop_cubit/data/models/cart.dart';
import '../../../data/models/product.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvents, CartState> {
  CartBloc() : super(InitialCartState()) {
    on<AddProductToCartEvent>(_addProductEvent);
    on<DeleteProductFromCartEvent>(_deleteProductEvent);
    on<MakeOrderEvent>(_makeOrderEvent);
  }

  Cart get cart => _cart;

  final Cart _cart = Cart(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    products: [],
  );

  void _addProductEvent(
    AddProductToCartEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      emit(LoadingCartState());

      int doesContain = _cart.products
          .indexWhere((element) => element.id == event.product.id);
      if (doesContain == -1) {
        _cart.products.add(event.product);
      }
      emit(LoadedCartState(cart: _cart));
    } catch (e) {
      emit(ErrorCartState(errorMessage: e.toString()));
    }
  }

  void _deleteProductEvent(
    DeleteProductFromCartEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      emit(LoadingCartState());
      _cart.products.removeWhere((product) => product.id == event.id);
      emit(LoadedCartState(cart: _cart));
    } catch (e) {
      emit(ErrorCartState(errorMessage: e.toString()));
    }
  }

  void _makeOrderEvent(
    MakeOrderEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      emit(LoadingCartState());
      _cart.products.clear();
      emit(LoadedCartState(cart: _cart));
    } catch (e) {
      emit(ErrorCartState(errorMessage: e.toString()));
    }
  }
}
