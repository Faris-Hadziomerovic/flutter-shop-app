import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/toast_messages.dart';
import '../exceptions/backup/product_recovery_exception.dart';
import '../helpers/generic_toast_messages.dart';
import '../providers/products_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  final String title;

  const SettingsScreen({super.key, this.title = 'Settings'});

  Future<void> recoverBackupedProducts(BuildContext context) async {
    try {
      await Provider.of<Products>(context, listen: false).recoverBackupAsync();
    } on ProductRecoveryException catch (e) {
      HelperToast.show(
        message: e.message,
      );

      return;
    }

    HelperToast.show(
      message: ToastMessages.successfulProductsRecovery,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 75,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => recoverBackupedProducts(context),
            child: Text(
              'Recover backup of products',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
