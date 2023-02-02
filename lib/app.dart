import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/cart_provider.dart';
import './providers/orders_provider.dart';
import './providers/products_provider.dart';
import './screens/add_edit_user_products_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/user_products_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(create: (_) => Products()),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
        ChangeNotifierProvider<Orders>(create: (_) => Orders()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            primary: Colors.red,
            secondary: Colors.amber,
          ),
          snackBarTheme: const SnackBarThemeData(
            elevation: 0,
            backgroundColor: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
          ),
          textTheme: const TextTheme(),
          cardTheme: const CardTheme(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          ProductsOverviewScreen.routeName: (_) => const ProductsOverviewScreen(),
          ProductDetailsScreen.routeName: (_) => const ProductDetailsScreen(),
          CartScreen.routeName: (_) => const CartScreen(),
          OrdersScreen.routeName: (_) => const OrdersScreen(),
          UserProductsScreen.routeName: (_) => const UserProductsScreen(),
          AddEditUserProductsScreen.newProductRouteName: (_) => const AddEditUserProductsScreen(),
          AddEditUserProductsScreen.editProductRouteName: (_) =>
              const AddEditUserProductsScreen(editExistingProduct: true),
          // ___Screen.routeName: (_) => const ___Screen(),
        },
      ),
    );
  }
}
