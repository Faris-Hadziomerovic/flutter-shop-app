import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product.dart';
import '../../providers/products_provider.dart';
import '../../screens/add_edit_user_products_screen.dart';

class UserProductsListItem extends StatelessWidget {
  final Product product;

  const UserProductsListItem({
    super.key,
    required this.product,
  });

  Future<void> onDelete(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).deleteAsync(id: product.id);
  }

  void onEdit(BuildContext context) {
    Navigator.of(context).pushNamed(
      AddEditUserProductsScreen.routeName,
      arguments: product.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 0,
      ),
      child: ListTile(
        isThreeLine: false,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: SizedBox(
            width: 60,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          product.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              Flexible(
                  child: IconButton(
                onPressed: () => onEdit(context),
                icon: const Icon(Icons.edit),
              )),
              Flexible(
                child: IconButton(
                    onPressed: () => onDelete(context),
                    icon: const Icon(Icons.delete_forever_rounded)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
