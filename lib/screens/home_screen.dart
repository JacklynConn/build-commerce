import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/consts/app_constants.dart';
import 'package:flutter_build_ecommerce/widgets/products/ctg_rounded_widget.dart';
import 'package:flutter_build_ecommerce/widgets/products/latest_arrival.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/app_name_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(
          fontSize: 20,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.24,
                child: ClipRRect(
                  // borderRadius: const BorderRadius.only(
                  //   topLeft: Radius.circular(16),
                  //   topRight: Radius.circular(16),
                  // ),
                  child: Swiper(
                    controller: SwiperController(),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        AppConstants.bannersImages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    autoplay: true,
                    itemCount: AppConstants.bannersImages.length,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.red,
                        color: Colors.white,
                      ),
                    ),
                    // control: const SwiperControl(),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: const TitleTextWidget(
                  label: "Latest arrival",
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 18),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: SizedBox(
                  height: size.height * 0.2,
                  child: ListView.builder(
                    itemCount: productProvider.getProducts.length < 10
                        ? productProvider.getProducts.length
                        : 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: productProvider.getProducts[index],
                        child: const LatestArrivalProductsWidget(),
                      );
                    },
                  ),
                ),
              ),
              const TitleTextWidget(label: "Categories"),
              const SizedBox(height: 18),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children:
                    List.generate(AppConstants.categoriesList.length, (index) {
                  return CategoryRoundedWidget(
                    name: AppConstants.categoriesList[index].name,
                    image: AppConstants.categoriesList[index].image,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
