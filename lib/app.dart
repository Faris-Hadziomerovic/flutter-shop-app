import 'package:flutter/material.dart';
import 'package:shop_app/data/products.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Products().products;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
      home: ProductsOverviewScreen(products: products),
      routes: {
        ProductsOverviewScreen.routeName: (context) => ProductsOverviewScreen(products: products),
        // ___Screen.routeName: (context) => const ___Screen(),
        // ___Screen.routeName: (context) => const ___Screen(),
      },
    );
  }
}
