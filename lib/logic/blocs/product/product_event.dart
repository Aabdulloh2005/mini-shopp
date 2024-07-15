part of 'product_bloc.dart';

sealed class ProductEvents {}

final class GetProductEvent extends ProductEvents {}

final class AddProductEvent extends ProductEvents {
  final String title;
  final String imageUrl;

  AddProductEvent({required this.title, required this.imageUrl});
}

final class EditProductEvent extends ProductEvents {
  final String id;
  final String title;
  final String imageUrl;

  EditProductEvent({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}

final class ToggleFavoriteEvent extends ProductEvents {
  final String id;

  ToggleFavoriteEvent({required this.id});
}

final class RemoveProductEvent extends ProductEvents {
  final String id;

  RemoveProductEvent({required this.id});
}
