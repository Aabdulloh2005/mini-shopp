import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_simple_online_shop_cubit/data/models/product.dart';
import 'package:very_simple_online_shop_cubit/logic/blocs/product/product_bloc.dart';
import 'package:very_simple_online_shop_cubit/ui/widgets/product_container.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite products'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is InitialProductState) {
            return const Center(child: Text('Add products!'));
          } else {
            final List<Product> favProducts = (state as LoadedProductState)
                .products
                .where((element) => element.isFavorite)
                .toList();
            return favProducts.isNotEmpty
                ? ListView.builder(
                    itemCount: favProducts.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ProductContainer(
                      isFavoriteScreen: true,
                      product: favProducts[index],
                    ),
                  )
                : const Center(
                    child: Text('You do not have favorite products!'),
                  );
          }
        },
      ),
    );
  }
}
