import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/text_constants.dart';
import './providers/cart_provider.dart';
import './providers/orders_provider.dart';
import './providers/products_provider.dart';
import './screens/add_edit_user_products_screen.dart';
import './screens/auth_screen.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/settings_screen.dart';
import './screens/user_products_screen.dart';
import './theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(create: (_) => Products()..fetchAndSetAsync()),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()..fetchAndSetAsync()),
        ChangeNotifierProvider<Orders>(create: (_) => Orders()..fetchAndSetAsync()),
      ],
      child: MaterialApp(
        title: TextConstants.appTitle,
        theme: AppTheme.appThemeData,
        home: const AuthScreen(),
        // home: const ProductsOverviewScreen(),
        routes: {
          AuthScreen.routeName: (_) => const AuthScreen(),
          ProductsOverviewScreen.routeName: (_) => const ProductsOverviewScreen(),
          ProductDetailsScreen.routeName: (_) => const ProductDetailsScreen(),
          CartScreen.routeName: (_) => const CartScreen(),
          OrdersScreen.routeName: (_) => const OrdersScreen(),
          UserProductsScreen.routeName: (_) => const UserProductsScreen(),
          AddEditUserProductsScreen.routeName: (_) => const AddEditUserProductsScreen(),
          SettingsScreen.routeName: (_) => const SettingsScreen(),
          // ___Screen.routeName: (_) => const ___Screen(),
        },
      ),
    );
  }
}
