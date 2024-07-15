import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_simple_online_shop_cubit/data/models/product.dart';
import 'package:very_simple_online_shop_cubit/logic/blocs/cart/cart_bloc.dart';
import 'package:very_simple_online_shop_cubit/logic/blocs/order/order_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = context.read<CartBloc>();
    final OrderBloc orderBloc = context.read<OrderBloc>();
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (BuildContext context, CartState state) {
          if (state is LoadedCartState) {
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.cart.products.length,
              itemBuilder: (BuildContext context, int index) {
                final Product product = state.cart.products[index];
                return Dismissible(
                  key: ValueKey(product.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    cartBloc.add(DeleteProductFromCartEvent(id: product.id));
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: Image.network(
                            fit: BoxFit.cover,
                            product.imageUrl,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          color: Colors.blue.withOpacity(0.3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Icon(

                              //   product.isFavorite
                              //       ? Icons.favorite
                              //       : Icons.favorite_border,
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Add product'));
        },
      ),
      floatingActionButton: FilledButton.icon(
        onPressed: () {
          orderBloc.add(AddOrderEvent(cart: cartBloc.cart));
          cartBloc.add(MakeOrderEvent());
        },
        label: const Text('Order'),
        icon: const Icon(Icons.shopping_cart_rounded),
      ),
    );
  }
}
