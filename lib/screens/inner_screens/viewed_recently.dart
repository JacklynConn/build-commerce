import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_build_ecommerce/services/assets_manager.dart';
import 'package:flutter_build_ecommerce/widgets/empty_bag.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import '../../widgets/products/product_widget.dart';

class ViewRecentlyScreen extends StatelessWidget {
  static const routeName = '/ViewRecentlyScreen';

  const ViewRecentlyScreen({super.key});

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your viewed recently is empty",
              subtitle:
                  "Looks like you didn't add anything to your cart \ngo ahead and start shopping now",
              buttonText: "Shopp now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: const TitleTextWidget(label: "Viewed Recently (5)"),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: 100,
              builder: (context, index) {
                return const ProductWidget(
                  productId: "",
                );
              },
              crossAxisCount: 2,
              // crossAxisSpacing: 10,
              // mainAxisSpacing: 10,
            ),
          );
  }
}
