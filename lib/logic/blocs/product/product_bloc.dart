import 'package:bloc/bloc.dart';

import '../../../data/models/product.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvents, ProductState> {
  ProductBloc() : super(InitialProductState()) {
    on<GetProductEvent>(_getProducts);
    on<AddProductEvent>(_addProduct);
    on<EditProductEvent>(_editProduct);
    on<ToggleFavoriteEvent>(_toggleFavorite);
    on<RemoveProductEvent>(_removeProduct);
  }

  final List<Product> _products = [];

  Future<void> _getProducts(
      GetProductEvent event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());
      await Future.delayed(const Duration(seconds: 2));
      emit(LoadedProductState(products: _products));
    } catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    }
  }

  Future<void> _addProduct(
      AddProductEvent event, Emitter<ProductState> emit) async {
    try {
      final Product product = Product(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: event.title,
        imageUrl: event.imageUrl,
      );
      emit(LoadingProductState());
      await Future.delayed(const Duration(seconds: 2));
      _products.add(product);

      emit(LoadedProductState(products: _products));
    } catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    }
  }

  Future<void> _editProduct(
      EditProductEvent event, Emitter<ProductState> emit) async {
    try {
      emit(LoadingProductState());
      await Future.delayed(const Duration(seconds: 2));

      int index = _products.indexWhere((element) => element.id == event.id);
      _products[index].title = event.title;
      _products[index].imageUrl = event.imageUrl;

      emit(LoadedProductState(products: _products));
    } catch (e) {
      emit(ErrorProductState(errorMessage: e.toString()));
    }
  }

  void _toggleFavorite(ToggleFavoriteEvent event, Emitter<ProductState> emit) {
    int index = _products.indexWhere((element) => element.id == event.id);
    _products[index].isFavorite = !_products[index].isFavorite;
    emit(LoadedProductState(products: _products));
  }

  void _removeProduct(RemoveProductEvent event, Emitter<ProductState> emit) {
    int index = _products.indexWhere((element) => element.id == event.id);
    _products.removeAt(index);
    emit(LoadedProductState(products: _products));
  }
}
