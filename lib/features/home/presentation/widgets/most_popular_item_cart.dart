import 'package:e_commerce_app/arguments/product_arguments.dart';
import 'package:e_commerce_app/features/home/data/simple_data.dart';
import 'package:e_commerce_app/features/home/presentation/pages/product_detail_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants.dart';
import '../../../../core/size_config.dart';

class MostPopularCard extends StatelessWidget {
  const MostPopularCard({
    super.key,
    required this.idTabBar,
  });

  final String idTabBar;

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('most_popular/$idTabBar');
    return Container(
      height: SizeConfig.screenHeight - getProportionateScreenHeight(200),
      padding: EdgeInsets.only(
        top: getProportionateScreenWidth(20),
        right: getProportionateScreenWidth(20),
        left: getProportionateScreenWidth(20),
      ),
      child: StreamBuilder(
        stream: ref.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic> map =
                snapshot.data!.snapshot.value as dynamic;

            List<dynamic> list = [];
            list.clear();
            list = map.values.toList();

            return SizedBox(
              height:
                  SizeConfig.screenHeight - getProportionateScreenHeight(200),
              child: GridView.builder(
                itemCount: list.length,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .6,
                    crossAxisSpacing:
                        getProportionateScreenWidth(kDefaultPadding),
                    mainAxisSpacing:
                        getProportionateScreenWidth(kDefaultPadding)),
                itemBuilder: (context, index) =>
                    MostPopularItem(data: list, index: index),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class MostPopularItem extends StatelessWidget {
  const MostPopularItem({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final List data;
  final int index;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailPage.route,
          arguments: ProductArguments(
              title: data[index]['title'],
              color: data[index]['color'],
              description: data[index]['description'],
              favorite: data[index]['favorite'],
              image: data[index]['list-image'],
              price: data[index]['price'],
              reviews: data[index]['reviews'],
              size: data[index]['size'],
              sold: data[index]['sold'],
              star: data[index]['star'],
              id: data[index]['id']),
        );
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(kDefaultPadding),
                  ),
                  margin: EdgeInsets.only(
                      bottom: getProportionateScreenWidth(kDefaultPadding)),
                  decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.blueGrey.withOpacity(.2)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15)),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: data[index]["image"] != null
                        ? Image.network(data[index]["image"])
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black45, width: 1),
                        color: Colors.black45,
                      ),
                      child: data[index]['favorite']
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 16,
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 16,
                            )),
                ),
              ],
            ),
            Text(
              data[index]['title'],
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(16)),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Row(
              children: [
                const Icon(Icons.star_half),
                Text("${data[index]['star']} | "),
                Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.blueGrey.withOpacity(.2)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "${data[index]['sold']} sold",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Text(
              "\$${data[index]['price']}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(16)),
            )
          ],
        ),
      ),
    );
  }
}

class MostPopularItemCard extends StatelessWidget {
  const MostPopularItemCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DataItemMostPopular data;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailPage.route);
      },
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(
                    getProportionateScreenWidth(kDefaultPadding),
                  ),
                  margin: EdgeInsets.only(
                      bottom: getProportionateScreenWidth(kDefaultPadding)),
                  decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.blueGrey.withOpacity(.2)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15)),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      data.image,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                      height: 24,
                      width: 24,
                      padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.black,
                      ),
                      child: data.isFavorites!
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 16,
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 16,
                            )),
                ),
              ],
            ),
            Text(
              data.title,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(16)),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Row(
              children: [
                const Icon(Icons.star_half),
                Text("${data.star} | "),
                Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  decoration: BoxDecoration(
                      color: isDarkMode
                          ? Colors.blueGrey.withOpacity(.2)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "${data.sold} sold",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(5),
            ),
            Text(
              "\$${data.price}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(16)),
            )
          ],
        ),
      ),
    );
  }
}
