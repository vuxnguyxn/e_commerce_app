import 'package:e_commerce_app/features/home/data/simple_data.dart';
import 'package:e_commerce_app/features/home/presentation/pages/categories_page.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/size_config.dart';

class CategoryItemCard extends StatelessWidget {
  const CategoryItemCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Category data;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SizedBox(
      width: getProportionateScreenWidth(80),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, CategoriesPage.route);
            },
            child: Container(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.blueGrey.withOpacity(.2)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(kDefaultPadding),
                ),
                child: Icon(data.icon)),
          ),
          SizedBox(
            height: getProportionateScreenHeight(kDefaultPadding),
          ),
          Text(data.title),
        ],
      ),
    );
  }
}
