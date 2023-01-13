import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class Checkout extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double height;
  final double width;

  const Checkout({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.buttonColor,
    this.buttonTextColor,
    this.height = 150,
    this.width = double.infinity,
  });

  onCheckout(BuildContext context) {
    // the context will be kept in the method for using the toast with context later on...
    // final subtotal = Provider.of<Cart>(context, listen: false).totalAmount;

    Fluttertoast.showToast(
      backgroundColor: Colors.black54,
      msg: 'Successful purchase! \nYour items will be on their way shortly',
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Colors.blueGrey.shade100;

    final cartData = Provider.of<Cart>(context);
    final canCheckout = cartData.cartIsNotEmpty;

    final totalPrice = cartData.totalAmount;
    final totalPriceLabel = '\$ ${totalPrice.toStringAsFixed(2)}';

    final textStyle =
        Theme.of(context).textTheme.headline6?.copyWith(color: textColor ?? Colors.black);

    return Column(
      children: [
        Container(
          width: width,
          height: height / 2,
          decoration: BoxDecoration(
            color: bgColor,
            border: const Border(
              top: BorderSide(color: Colors.black38, width: 0),
              bottom: BorderSide(color: Colors.black38, width: 0),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'TOTAL:',
                  style: textStyle,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  totalPriceLabel,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: width,
          height: height / 2,
          color: bgColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child: ElevatedButton(
              onPressed: canCheckout ? () => onCheckout(context) : null,
              child: Text(
                'Checkout',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
