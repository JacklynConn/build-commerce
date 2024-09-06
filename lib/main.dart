import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/providers/order_provider.dart';
import '/providers/user_provider.dart';
import '/providers/cart_provider.dart';
import '/providers/product_provider.dart';
import '/providers/viewed_prod_provider.dart';
import '/providers/wishlist_provider.dart';
import '/root_screen.dart';
import '/screens/auth/ForgotPasswordScreen.dart';
import '/screens/auth/login.dart';
import '/screens/auth/register.dart';
import '/screens/inner_screens/orders/orders_screen.dart';
import '/screens/inner_screens/product_details.dart';
import '/screens/inner_screens/viewed_recently.dart';
import '/screens/inner_screens/wishlist.dart';
import '/screens/search_screen.dart';
import '/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '/consts/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapShot.hasError) {
              return Scaffold(
                body: SelectableText(
                  "An error has been occurred ${snapShot.error}",
                ),
              );
            }
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ThemeProvider()),
              ChangeNotifierProvider(create: (_) => ProductProvider()),
              ChangeNotifierProvider(create: (_) => CartProvider()),
              ChangeNotifierProvider(create: (_) => WishlistProvider()),
              ChangeNotifierProvider(create: (_) => ViewedProdProvider()),
              ChangeNotifierProvider(create: (_) => UserProvider()),
              ChangeNotifierProvider(create: (_) => OrdersProvider()),
            ],
            child: Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Show Smart AR',
                  theme: Styles.themeData(
                      isDarkTheme: themeProvider.getIsDarkTheme,
                      context: context),
                  home: const RootScreen(),
                  routes: {
                    ProductDetails.routeName: (context) =>
                        const ProductDetails(),
                    WishlistScreen.routeName: (context) =>
                        const WishlistScreen(),
                    ViewRecentlyScreen.routeName: (context) =>
                        const ViewRecentlyScreen(),
                    LoginScreen.routeName: (context) => const LoginScreen(),
                    RegisterScreen.routeName: (context) =>
                        const RegisterScreen(),
                    OrderScreenFree.routeName: (context) =>
                        const OrderScreenFree(),
                    ForgotPasswordScreen.routeName: (context) =>
                        const ForgotPasswordScreen(),
                    SearchScreen.routeName: (context) => const SearchScreen(),
                    RootScreen.routeName: (context) => const RootScreen(),
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
