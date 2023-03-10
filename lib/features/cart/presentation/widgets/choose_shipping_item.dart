import 'package:e_commerce_app/features/cart/data/cart_data.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/size_config.dart';

class ChooseShippingItem extends StatefulWidget {
  const ChooseShippingItem({
    super.key,
    required this.isDarkMode,
    required this.data,
    required this.index,
  });

  final bool isDarkMode;
  final DeliveryShipping data;
  final int index;

  @override
  State<ChooseShippingItem> createState() => _ShippingAddressItemState();
}

class _ShippingAddressItemState extends State<ChooseShippingItem> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(kDefaultPadding / 2),
      ),
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(kDefaultPadding / 2)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.isDarkMode ? Colors.blueGrey.withOpacity(.2) : null),
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(kDefaultPadding)),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.grey.withOpacity(.2), width: 2),
                  shape: BoxShape.circle,
                  color: widget.isDarkMode ? Colors.white : Colors.black),
              padding: EdgeInsets.all(getProportionateScreenWidth(8)),
              child: Icon(
                Icons.delivery_dining,
                color: widget.isDarkMode ? Colors.black : Colors.white,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.data.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(kDefaultPadding / 4),
                ),
                Text(
                  widget.data.content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Text('\$${widget.data.price}'),
          Radio(
            value: widget.index,
            groupValue: _selected,
            onChanged: (value) {
              setState(() {
                _selected = value!;
              });
            },
            activeColor: widget.isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
