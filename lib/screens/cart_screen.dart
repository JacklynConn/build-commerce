import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/services/assets_manager.dart';
import 'package:flutter_build_ecommerce/widgets/empty_bag.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmptyBagWidget(
        imagePath: AssetsManager.shoppingBasket,
        title: "Your cart is empty",
        subtitle:
            "Looks like you didn't add anything to your cart \ngo ahead and start shopping now",
        buttonText: "Shopp now",
      ),
    );
  }
}
