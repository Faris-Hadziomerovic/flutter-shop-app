import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/cart_provider.dart';
import './providers/products_provider.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(create: (_) => Products()),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            primary: Colors.red,
            secondary: Colors.amber,
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
          ProductsOverviewScreen.routeName: (context) => const ProductsOverviewScreen(),
          ProductDetailsScreen.routeName: (context) => const ProductDetailsScreen(),
          // ___Screen.routeName: (context) => const ___Screen(),
        },
      ),
    );
  }
}
