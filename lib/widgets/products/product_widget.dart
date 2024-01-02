import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/providers/cart_provider.dart';
import 'package:flutter_build_ecommerce/providers/product_provider.dart';
import 'package:flutter_build_ecommerce/widgets/products/heart_btn.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:provider/provider.dart';
import '../../screens/inner_screens/product_details.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, required this.productId});

  final String productId;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    // final productModelProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productProvider.findByProdId(widget.productId);
    // Cart Provider
    final cartProvider = Provider.of<CartProvider>(context);

    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  ProductDetails.routeName,
                  arguments: getCurrProduct.productId,
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.productImage,
                      width: double.infinity,
                      height: size.height * 0.22,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: TitleTextWidget(
                          label: getCurrProduct.productTitle,
                          maxLines: 2,
                          fontSize: 18,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: HeartButtonWidget(
                          productId: getCurrProduct.productId,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: SubtitleWidget(
                            label: getCurrProduct.productPrice.toString(),
                          ),
                        ),
                        Flexible(
                          child: Material(
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.lightBlue,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16.0),
                              splashColor: Colors.red,
                              onTap: () {
                                if (cartProvider.isProductInCart(
                                    productId: getCurrProduct.productId)) {
                                  return;
                                }
                                cartProvider.addProductToCart(
                                  productId: getCurrProduct.productId,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  cartProvider.isProductInCart(
                                          productId: getCurrProduct.productId)
                                      ? Icons.check
                                      : Icons.add_shopping_cart_rounded,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 1,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
  }
}
