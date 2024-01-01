import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/root_screen.dart';
import 'package:flutter_build_ecommerce/screens/auth/login.dart';
import 'package:flutter_build_ecommerce/screens/auth/register.dart';
import 'package:flutter_build_ecommerce/screens/inner_screens/product_details.dart';
import 'package:flutter_build_ecommerce/screens/inner_screens/viewed_recently.dart';
import 'package:flutter_build_ecommerce/screens/inner_screens/wishlist.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Show Smart AR',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const LoginScreen(),
          routes: {
            ProductDetails.routeName: (context) => const ProductDetails(),
            WishlistScreen.routeName: (context) => const WishlistScreen(),
            ViewRecentlyScreen.routeName: (context) => const ViewRecentlyScreen(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
          },
        );
      }),
    );
  }
}
