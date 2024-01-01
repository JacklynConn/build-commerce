import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/models/product_model.dart';
import 'package:flutter_build_ecommerce/widgets/products/heart_btn.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:provider/provider.dart';
import '../../screens/inner_screens/product_details.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final productModelProvider = Provider.of<ProductModel>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, ProductDetails.routeName);
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: FancyShimmerImage(
                imageUrl: productModelProvider.productImage,
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
                    label: productModelProvider.productTitle,
                    maxLines: 2,
                    fontSize: 18,
                  ),
                ),
                const Flexible(
                  flex: 2,
                  child: HeartButtonWidget(),
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
                      label: productModelProvider.productPrice.toString(),
                    ),
                  ),
                  Flexible(
                    child: Material(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.lightBlue,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16.0),
                        splashColor: Colors.red,
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add_shopping_cart_rounded,
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
