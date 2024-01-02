import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../models/viewed_prod_model.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewProdModel> _viewedProdItem = {};

  Map<String, ViewProdModel> get getProductItems {
    return _viewedProdItem;
  }

  // bool isProductInViewedProd({required String productId}) {
  //   return _viewedProdItem.containsKey(productId);
  // }

  void addProductToHistory({required String productId}) {
    _viewedProdItem.putIfAbsent(
      productId,
      () => ViewProdModel(
        id: const Uuid().v4(),
        productId: productId,
      ),
    );
    notifyListeners();
  }

// void clearLocalWishlist() {
//   _viewedProdItem.clear();
//   notifyListeners();
// }
}
