import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
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
