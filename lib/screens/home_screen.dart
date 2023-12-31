import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/consts/app_constants.dart';
import 'package:flutter_build_ecommerce/widgets/products/latest_arrival.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import '../services/assets_manager.dart';
import '../widgets/app_name_text.dart';
import '/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const TitleTextWidget(label: "Latest Arrivals"),
            const SizedBox(height: 18),
            SizedBox(
              height: size.height * 0.2,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const LatestArrivalProductsWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
