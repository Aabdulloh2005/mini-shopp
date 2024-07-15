part of 'product_bloc.dart';

sealed class ProductState {}

final class InitialProductState extends ProductState {}

final class LoadingProductState extends ProductState {}

final class LoadedProductState extends ProductState {
  final List<Product> products;

  LoadedProductState({required this.products});
}

final class ErrorProductState extends ProductState {
  final String errorMessage;

  ErrorProductState({required this.errorMessage});
}
