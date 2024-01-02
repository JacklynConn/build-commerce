import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/services/assets_manager.dart';
import 'package:flutter_build_ecommerce/services/my_app_method.dart';
import 'package:flutter_build_ecommerce/widgets/empty_bag.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:provider/provider.dart';
import '../../providers/wishlist_provider.dart';
import '../../widgets/products/product_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';

  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return wishlistProvider.getWishlistItems.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.bagWish,
              title: "Your wishlist is empty",
              subtitle:
                  "Looks like you didn't add anything to your cart \ngo ahead and start shopping now",
              buttonText: "Shopp now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitleTextWidget(
                label: "Wishlist (${wishlistProvider.getWishlistItems.length})",
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorORWarningDialog(
                        isError: false,
                        context: context,
                        subtitle: "Remove Items",
                        fct: () {
                          wishlistProvider.clearLocalWishlist();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DynamicHeightGridView(
                itemCount: wishlistProvider.getWishlistItems.length,
                builder: (context, index) {
                  return ProductWidget(
                    productId: wishlistProvider.getWishlistItems.values
                        .toList()[index]
                        .productId,
                  );
                },
                crossAxisCount: 2,
                // crossAxisSpacing: 10,
                // mainAxisSpacing: 10,
              ),
            ),
          );
  }
}
