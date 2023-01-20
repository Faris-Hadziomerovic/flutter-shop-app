import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';
import '../screens/orders_screen.dart';

class Checkout extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double width;
  final double height;
  final Axis direction;

  const Checkout({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.buttonColor,
    this.buttonTextColor,
    this.width = double.infinity,
    this.height = 150,
    this.direction = Axis.vertical,
  }) : assert(!(direction == Axis.horizontal && width == double.infinity));

  onCheckout(BuildContext context) {
    // the context will be kept in the method for using the toast with context later on...

    Fluttertoast.showToast(
      backgroundColor: Colors.black54,
      msg: 'Successful purchase! \nYour items will be on their way shortly',
    );

    final cartData = Provider.of<Cart>(context, listen: false);
    final subtotal = cartData.totalAmount;
    final cartItems = cartData.cart.values.toList();

    Provider.of<Orders>(context, listen: false).addOrders(cartItems, subtotal);
    Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
    cartData.clear();
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

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: const Border(
          top: BorderSide(color: Colors.black38, width: 0),
          bottom: BorderSide(color: Colors.black38, width: 0),
        ),
      ),
      child: Flex(
        direction: direction,
        children: [
          SizedBox(
            width: direction == Axis.vertical ? width : width / 2,
            height: height / 2,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'TOTAL:',
                    style: textStyle,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    totalPriceLabel,
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ),
          direction == Axis.vertical
              ? const Divider(
                  height: 0,
                  thickness: 1,
                )
              : SizedBox(
                  height: height / 2.5,
                  child: const VerticalDivider(
                    width: 0,
                    thickness: 1,
                  ),
                ),
          SizedBox(
            width: direction == Axis.vertical ? width : width / 2,
            height: height / 2,
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
      ),
    );
  }
}
