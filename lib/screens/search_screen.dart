import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/models/product_model.dart';
import 'package:flutter_build_ecommerce/providers/product_provider.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:provider/provider.dart';
import '../widgets/products/product_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';

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

  List<ProductModel> productListSearch = [];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> productsList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(
            ctgName: passedCategory,
          );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: TitleTextWidget(label: passedCategory ?? "Search"),
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: Image.asset(AssetsManager.shoppingCart),
          // ),
        ),
        body: productsList.isEmpty
            ? const Center(child: TitleTextWidget(label: "No product found"))
            : StreamBuilder<List<ProductModel>>(
                stream: productProvider.fetchProductsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: TitleTextWidget(
                        label: snapshot.error.toString(),
                      ),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: TitleTextWidget(
                        label: "No product has been added",
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8.0),
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
                            setState(() {
                              productListSearch = productProvider.searchQuery(
                                searchText: searchTextController.text,
                                passedList: productsList,
                              );
                            });
                          },
                          onSubmitted: (value) {
                            setState(() {
                              productListSearch = productProvider.searchQuery(
                                searchText: searchTextController.text,
                                passedList: productsList,
                              );
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        if (searchTextController.text.isNotEmpty &&
                            productListSearch.isEmpty) ...[
                          const Center(
                            child: TitleTextWidget(
                              label: "No result found",
                              fontSize: 40,
                            ),
                          ),
                        ],
                        Expanded(
                          child: DynamicHeightGridView(
                            itemCount: searchTextController.text.isNotEmpty
                                ? productListSearch.length
                                : productsList.length,
                            builder: (context, index) {
                              return ChangeNotifierProvider.value(
                                value: productsList[index],
                                child: ProductWidget(
                                  productId:
                                      searchTextController.text.isNotEmpty
                                          ? productListSearch[index].productId
                                          : productsList[index].productId,
                                ),
                              );
                            },
                            crossAxisCount: 2,
                            // crossAxisSpacing: 10,
                            // mainAxisSpacing: 10,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
