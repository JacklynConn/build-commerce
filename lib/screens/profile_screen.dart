import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/services/assets_manager.dart';
import 'package:flutter_build_ecommerce/widgets/app_name_text.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: TitleTextWidget(
                  label: "Please login to have unlimited access",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.background,
                        width: 3,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextWidget(label: "Mak Mach"),
                      SubtitleWidget(label: "coding.with.makmach@gmail.com"),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleTextWidget(label: "General"),
                  CustomListTile(
                    imagePath: AssetsManager.orderSvg,
                    text: "All orders",
                    function: () {},
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.wishlistSvg,
                    text: "Wishlist",
                    function: () {},
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.recent,
                    text: "Viewed recently",
                    function: () {},
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.address,
                    text: "Address",
                    function: () {},
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(height: 7),
                  const TitleTextWidget(label: "Settings"),
                  const SizedBox(height: 7),
                  SwitchListTile(
                    secondary: Image.asset(AssetsManager.theme, height: 30),
                    title: Text(themeProvider.getIsDarkTheme
                        ? 'Dark Theme'
                        : 'Light Theme'),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.login, color: Colors.white),
                label: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });

  final String imagePath, text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        imagePath,
        height: 30,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
      title: SubtitleWidget(label: text),
    );
  }
}
