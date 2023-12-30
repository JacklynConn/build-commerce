import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import '/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SubtitleWidget(
            label: "Hi again!",
            fontSize: 60,
            color: Colors.red,
          ),
          TitleTextWidget(
            label: "This is a title" * 10,
            fontSize: 50,
            maxLines: 2,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Hello world'),
          ),
          SwitchListTile(
            title: Text(
              themeProvider.getIsDarkTheme ? 'Dark Theme' : 'Light Theme',
            ),
            value: themeProvider.getIsDarkTheme,
            onChanged: (value) {
              themeProvider.setDarkTheme(themeValue: value);
            },
          ),
        ],
      ),
    );
  }
}
