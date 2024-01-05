import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String productId,
      productTitle,
      productPrice,
      productCategory,
      productDescription,
      productImage,
      productQuantity;
  Timestamp? createdAt;
  ProductModel({
    required this.productId,
    required this.productTitle,
    required this.productPrice,
    required this.productCategory,
    required this.productDescription,
    required this.productImage,
    required this.productQuantity,
    this.createdAt,
  });

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    return ProductModel(
      productId: doc.get("productId"),
      productTitle: doc.get("productTitle"),
      productPrice: doc.get("productPrice"),
      productCategory: doc.get("productCategory"),
      productDescription: doc.get("productDescription"),
      productImage: doc.get("productImage"),
      productQuantity: doc.get("productQuantity"),
      createdAt: doc.get("createdAt"),
    );
  }
}
