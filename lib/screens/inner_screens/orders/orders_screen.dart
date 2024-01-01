import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/services/assets_manager.dart';
import 'package:flutter_build_ecommerce/widgets/empty_bag.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';

import 'orders_widget.dart';

class OrderScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreenFree';

  const OrderScreenFree({super.key});

  @override
  State<OrderScreenFree> createState() => _OrderScreenFreeState();
}

class _OrderScreenFreeState extends State<OrderScreenFree> {
  bool isEmptyOrders = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleTextWidget(label: "Placed Orders"),
      ),
      body: isEmptyOrders
          ? EmptyBagWidget(
              imagePath: AssetsManager.orderBag,
              title: "No orders has been placed yet",
              subtitle: "",
              buttonText: "Shop Now",
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return const OrdersWidgetFree();
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: 15,
            ),
    );
  }
}
