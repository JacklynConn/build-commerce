import 'package:flutter/cupertino.dart';
import 'package:flutter_build_ecommerce/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItem = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItem;
  }

  bool isProductInWishlist({required String productId}) {
    return _wishlistItem.containsKey(productId);
  }

  void addOrRemoveFromWishlist({required String productId}) {
    if (_wishlistItem.containsKey(productId)) {
      _wishlistItem.remove(productId);
    } else {
      _wishlistItem.putIfAbsent(
        productId,
        () => WishlistModel(
          id: const Uuid().v4(),
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void clearLocalWishlist() {
    _wishlistItem.clear();
    notifyListeners();
  }
}
