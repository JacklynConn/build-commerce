import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/screens/cart/cart_screen.dart';
import 'package:flutter_build_ecommerce/screens/home_screen.dart';
import 'package:flutter_build_ecommerce/screens/profile_screen.dart';
import 'package:flutter_build_ecommerce/screens/search_screen.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController controller;
  int currentScreen = 0;
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
    controller = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
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
          controller.jumpToPage(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(IconlyLight.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Badge(
              backgroundColor: Colors.blue,
              label: Text("6"),
                child: Icon(IconlyLight.bag2)),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.profile),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
