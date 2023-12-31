import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import '../services/assets_manager.dart';

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
                    child: const Icon(Icons.clear, color: Colors.red,),
                  ),
                  hintText: "Search Products",
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
            ],
          ),
        ),
      ),
    );
  }
}
