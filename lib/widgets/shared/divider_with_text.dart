import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String? text;

  const DividerWithText({
    super.key,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    const expandedDivider = Flexible(
      child: Divider(
        height: 0,
        thickness: 1,
      ),
    );

    return Row(
      children: [
        expandedDivider,
        text != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 15,
                ),
                child: Text(
                  text!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )
            : const SizedBox(height: 25),
        expandedDivider,
      ],
    );
  }
}
