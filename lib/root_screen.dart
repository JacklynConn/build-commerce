import 'dart:developer';
import 'package:flutter/material.dart';
import '/providers/product_provider.dart';
import '/providers/cart_provider.dart';
import '/screens/cart/cart_screen.dart';
import '/screens/home_screen.dart';
import '/screens/profile_screen.dart';
import '/screens/search_screen.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  static const routeName = '/RootScreen';

  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController controller;
  int currentScreen = 0;
  bool isLoadingProds = true;
  List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(
      initialPage: currentScreen,
    );
  }

  Future<void> fetchFCT() async {
    final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    try {
      Future.wait({
        productsProvider.fetchProducts(),
      });
      Future.wait({
        cartProvider.fetchCart(),
      });
    } catch (error) {
      log(error.toString());
    } finally {
      setState(() {
        isLoadingProds = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoadingProds) {
      fetchFCT();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedIndex: currentScreen,
        elevation: 0,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: 'Home',
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: const Icon(IconlyBold.bag2),
            icon: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                return Badge(
                  backgroundColor: Colors.blue,
                  label: Text(cartProvider.getCartItems.length.toString()),
                  child: const Icon(IconlyLight.bag2),
                );
              },
            ),
            label: "Cart",
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
