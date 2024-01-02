import 'package:flutter/cupertino.dart';

class ViewProdModel with ChangeNotifier {
  final String id;
  final String productId;

  ViewProdModel({
    required this.id,
    required this.productId,
  });
}
