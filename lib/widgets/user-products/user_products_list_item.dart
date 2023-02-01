import 'package:flutter/material.dart';

import '../../helpers/generic_toast_messages.dart';
import '../../providers/product.dart';

class UserProductsListItem extends StatelessWidget {
  final Product product;

  const UserProductsListItem({
    super.key,
    required this.product,
  });

  onDelete(BuildContext context) {
    HelperToast.showNotImplementedToast();
  }

  onEdit(BuildContext context) {
    HelperToast.showNotImplementedToast();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 0,
      ),
      child: ListTile(
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
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          product.description,
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
