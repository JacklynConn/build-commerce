import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_build_ecommerce/models/wishlist_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../services/my_app_method.dart';

class WishlistProvider with ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItem = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItem;
  }

  bool isProductInWishlist({required String productId}) {
    return _wishlistItem.containsKey(productId);
  }

  // Firebase
  final usersDB = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;

  Future<void> addToWishlistFirebase({
    required String productId,
    required BuildContext context,
  }) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "No user found",
        fct: () {},
      );
      return;
    }
    final uid = user.uid;
    final wishlistId = const Uuid().v4();
    try {
      usersDB.doc(uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ]),
      });
      // await fetchWishlist();
      Fluttertoast.showToast(msg: "Item has been added to wishlist");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchWishlist() async {
    User? user = _auth.currentUser;
    if (user == null) {
      // log("The function has been called but and the user is null");
      _wishlistItem.clear();
    }
    try {
      final userDoc = await usersDB.doc(user!.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('userWish')) {
        return;
      }
      final leng = userDoc.get('userWish').length;
      for (var index = 0; index < leng; index++) {
        _wishlistItem.putIfAbsent(
          userDoc.get('userWish')[index]['productId'],
          () => WishlistModel(
            id: userDoc.get('userWish')[index]['wishlistId'],
            productId: userDoc.get('userWish')[index]['productId'],
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeWishlistItemFromFirebase({
    required String wishlistId,
    required String productId,
  }) async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        'userWish': FieldValue.arrayRemove([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ]),
      });
      _wishlistItem.remove(productId);
      // await fetchWishlist();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> clearWishlistFromFirebase() async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        'userWish': [],
      });
      _wishlistItem.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  // Local
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
