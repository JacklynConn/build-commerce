import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/screens/cart/quantity_btm_sheet.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../models/cart_model.dart';
import '../../providers/product_provider.dart';
import '../../widgets/products/heart_btn.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModelProvider = Provider.of<CartModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct =
        productProvider.findByProdId(cartModelProvider.productId);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                        imageUrl: getCurrProduct.productImage,
                        height: size.height * 0.2,
                        width: size.height * 0.2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IntrinsicWidth(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: TitleTextWidget(
                                  label: getCurrProduct.productTitle,
                                  maxLines: 2,
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const HeartButtonWidget(),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SubtitleWidget(
                                label: "${getCurrProduct.productPrice}\$",
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                              const Spacer(),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  side: const BorderSide(color: Colors.blue),
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    // shape: const RoundedRectangleBorder(
                                    //   borderRadius: BorderRadius.only(
                                    //     topLeft: Radius.circular(16),
                                    //     topRight: Radius.circular(16),
                                    //   ),
                                    // ),
                                    context: context,
                                    builder: (context) {
                                      return const QuantityBottomSheetWidget();
                                    },
                                  );
                                },
                                icon: const Icon(IconlyLight.arrowDown2),
                                label: Text(
                                  "Qty: ${cartModelProvider.quantity}",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
