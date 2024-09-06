import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/services/assets_manager.dart';
import 'package:flutter_build_ecommerce/widgets/empty_bag.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:provider/provider.dart';
import '../../../models/order_model.dart';
import '../../../providers/order_provider.dart';
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
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitleTextWidget(label: "Placed Orders"),
      ),
      body: FutureBuilder<List<OrdersModelAdvanced>>(
        future: ordersProvider.fetchOrder(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child:
                  SelectableText("An error has been occured ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || ordersProvider.getOrders.isEmpty) {
            return EmptyBagWidget(
                imagePath: AssetsManager.orderBag,
                title: "No orders has been placed yet",
                subtitle: "",
                buttonText: "Shop now");
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: OrdersWidgetFree(
                    ordersModelAdvanced: ordersProvider.getOrders[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        }),
      ),
    );
  }
}
