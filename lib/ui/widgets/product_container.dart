// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gap/gap.dart';
// import 'package:very_simple_online_shop_cubit/data/models/product.dart';
// import 'package:very_simple_online_shop_cubit/logic/blocs/cart/cart_bloc.dart';
// import 'package:very_simple_online_shop_cubit/logic/blocs/product/product_bloc.dart';
// import 'package:very_simple_online_shop_cubit/ui/widgets/manage_product.dart';

// class ProductContainer extends StatelessWidget {
//   final bool isFavoriteScreen;
//   final Product product;

//   const ProductContainer({
//     super.key,
//     required this.product,
//     required this.isFavoriteScreen,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.hardEdge,
//       margin: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.amber.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Image.network(
//             product.imageUrl,
//             width: 100,
//             height: 80,
//             fit: BoxFit.cover,
//           ),
//           const Gap(10),
//           Expanded(child: Text(product.title)),
//           const Gap(10),
//           Column(
//             children: [
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) => ManageProduct(
//                           isEdit: true,
//                           product: product,
//                         ),
//                       );
//                     },
//                     icon: const Icon(Icons.edit),
//                   ),
//                   IconButton(
//                     onPressed: () => context
//                         .read<ProductBloc>()
//                         .add(RemoveProductEvent(id: product.id)),
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () => context
//                         .read<ProductBloc>()
//                         .add(ToggleFavoriteEvent(id: product.id)),
//                     icon: Icon(
//                       product.isFavorite
//                           ? Icons.favorite
//                           : Icons.favorite_border,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => context
//                         .read<CartBloc>()
//                         .add(AddProductToCartEvent(product: product)),
//                     icon: const Icon(Icons.add_shopping_cart_outlined),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:very_simple_online_shop_cubit/data/models/product.dart';
import 'package:very_simple_online_shop_cubit/logic/blocs/cart/cart_bloc.dart';
import 'package:very_simple_online_shop_cubit/logic/blocs/product/product_bloc.dart';
import 'package:very_simple_online_shop_cubit/ui/widgets/manage_product.dart';

class ProductContainer extends StatelessWidget {
  final bool isFavoriteScreen;
  final Product product;

  const ProductContainer({
    super.key,
    required this.product,
    required this.isFavoriteScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            product.imageUrl,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              product.title,
            ),
          ),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ManageProduct(
                        isEdit: true,
                        product: product,
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => context
                      .read<ProductBloc>()
                      .add(RemoveProductEvent(id: product.id)),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
                IconButton(
                  onPressed: () => context
                      .read<ProductBloc>()
                      .add(ToggleFavoriteEvent(id: product.id)),
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                ),
                IconButton(
                  onPressed: () => context
                      .read<CartBloc>()
                      .add(AddProductToCartEvent(product: product)),
                  icon: const Icon(Icons.add_shopping_cart_outlined),
                ),
              ],
            ),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}
