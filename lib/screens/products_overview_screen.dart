import 'package:flutter/material.dart';

import '../enums/filter_options.dart';
import '../widgets/products_overview_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/products-overview-screen';

  final String title;

  const ProductsOverviewScreen({super.key, this.title = 'Products overview'});

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  FilterOptions _filterOptions = FilterOptions.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: PopupMenuButton(
              child: const Icon(Icons.more_vert),
              onSelected: (value) {
                setState(() {
                  _filterOptions = value;
                });
              },
              itemBuilder: (_) {
                return [
                  const PopupMenuItem(
                    value: FilterOptions.favourites,
                    child: Text('Show favourites'),
                  ),
                  const PopupMenuItem(
                    value: FilterOptions.all,
                    child: Text('Show all products'),
                  ),
                ];
              },
            ),
          )
        ],
      ),
      body: ProductsOverviewGrid(filterOptions: _filterOptions),
    );
  }
}
