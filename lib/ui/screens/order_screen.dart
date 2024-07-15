import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_simple_online_shop_cubit/logic/blocs/order/order_bloc.dart';
import 'package:very_simple_online_shop_cubit/data/models/product.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (BuildContext context, OrderState state) {
          if (state is OrderLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoadedState) {
            if (state.orders.orders.isEmpty) {
              return const Center(child: Text('No orders available.'));
            }

            return ListView.builder(
              itemCount: state.orders.orders.length,
              itemBuilder: (context, index) {
                final cart = state.orders.orders[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text('Order ID: ${cart.id}'),
                    children: cart.products.map((Product product) {
                      return ListTile(
                        leading: Image.network(product.imageUrl),
                        title: Text(product.title),
                        subtitle: Text(product.isFavorite ? 'Favorite' : ''),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          } else if (state is OrderErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const Center(child: Text('No orders available.'));
          }
        },
      ),
    );
  }
}
