import 'package:flutter/material.dart';
import '/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '/consts/theme_data.dart';
import '/screens/home_screen.dart';

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
          theme: Styles.themeData(isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const HomeScreen(),
        );
      }),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}

