import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_simple_online_shop_cubit/cubit/theme/theme_cubit.dart';
import 'package:very_simple_online_shop_cubit/data/models/product.dart';
import 'package:very_simple_online_shop_cubit/logic/blocs/product/product_bloc.dart';
import 'package:very_simple_online_shop_cubit/ui/screens/cart_screen.dart';
import 'package:very_simple_online_shop_cubit/ui/screens/favorite_screen.dart';
import 'package:very_simple_online_shop_cubit/ui/screens/order_screen.dart';
import 'package:very_simple_online_shop_cubit/ui/widgets/manage_product.dart';
import 'package:very_simple_online_shop_cubit/ui/widgets/product_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> _appText = ['Home', 'Cart', 'Orders'];
  final List<Widget> _screens = [
    HomeScreenBody(),
    const CartScreen(),
    const OrderScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeCubit themeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(_appText[_selectedIndex]),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (BuildContext context) => const FavoriteScreen(),
              ),
            ),
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                children: [
                  Text(
                    "Settings",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SwitchListTile(
              title: const Text('Dark mode'),
              value: themeCubit.state,
              onChanged: (value) => themeCubit.toggleTheme(),
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) =>
                    const ManageProduct(isEdit: false),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (BuildContext context, ProductState state) {
        if (state is InitialProductState) {
          return const Center(child: Text('Add products!'));
        } else if (state is LoadingProductState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorProductState) {
          return Center(child: Text('error: ${state.errorMessage}'));
        } else if (state is LoadedProductState) {
          final List<Product> products = state.products;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) => ProductContainer(
              isFavoriteScreen: false,
              product: products[index],
            ),
          );
        } else {
          return const Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}
