import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/size_config.dart';

class TotalPriceAndAddToCart extends StatelessWidget {
  const TotalPriceAndAddToCart({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Price",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                ),
              ),
              const Text(
                "\$800",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(kDefaultPadding * 2.5)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: isDarkMode ? Colors.white : Colors.black),
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_basket,
              size: 16,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
            label: Text(
              'Add to Cart',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDarkMode ? Colors.black : Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
