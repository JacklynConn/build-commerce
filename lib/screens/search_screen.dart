import 'dart:developer';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/models/product_model.dart';
import 'package:flutter_build_ecommerce/providers/product_provider.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:provider/provider.dart';
import '../services/assets_manager.dart';
import '../widgets/products/product_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const TitleTextWidget(label: "Search Products"),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        searchTextController.clear();
                        FocusScope.of(context).unfocus();
                      });
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                  hintText: "Search...",
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.6),
                  ),
                ),
                onChanged: (value) {
                  log(searchTextController.text);
                },
                onSubmitted: (value) {
                  log(searchTextController.text);
                },
              ),
              const SizedBox(height: 15),
              Expanded(
                child: DynamicHeightGridView(
                  itemCount: productProvider.getProducts.length,
                  builder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: productProvider.getProducts[index],
                      child: const ProductWidget(),
                    );
                  },
                  crossAxisCount: 2,
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
