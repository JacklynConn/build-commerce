import 'package:flutter_build_ecommerce/services/assets_manager.dart';
import '../models/categories_model.dart';

class AppConstants {
  static const String productImageUrl =
      'https://images-na.ssl-images-amazon.com/images/I/71M57EPPWAL._AC_UL1500_.jpg';
  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];

  static List<CategoryModel> categoriesList = [
    CategoryModel(
      id: AssetsManager.mobiles,
      name: "Mobiles",
      image: AssetsManager.mobiles,
    ),
    CategoryModel(
      id: AssetsManager.pc,
      name: "Laptops",
      image: AssetsManager.pc,
    ),
    CategoryModel(
      id: AssetsManager.electronics,
      name: "Electronics",
      image: AssetsManager.electronics,
    ),
    CategoryModel(
      id: AssetsManager.watch,
      name: "Watches",
      image: AssetsManager.watch,
    ),
    CategoryModel(
      id: AssetsManager.fashion,
      name: "Fashion",
      image: AssetsManager.fashion,
    ),
    CategoryModel(
      id: AssetsManager.cosmetics,
      name: "Cosmetics",
      image: AssetsManager.cosmetics,
    ),
    CategoryModel(
      id: AssetsManager.shoes,
      name: "Shoes",
      image: AssetsManager.shoes,
    ),
    CategoryModel(
      id: AssetsManager.book,
      name: "Books",
      image: AssetsManager.book,
    ),
  ];
}
