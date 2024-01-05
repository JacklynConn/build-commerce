import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/models/user_model.dart';
import 'package:flutter_build_ecommerce/screens/loading_manager.dart';
import '../providers/user_provider.dart';
import '/screens/inner_screens/viewed_recently.dart';
import '/services/assets_manager.dart';
import '/widgets/app_name_text.dart';
import '/widgets/subtitle_text.dart';
import '/widgets/title_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/my_app_method.dart';
import 'auth/login.dart';
import 'inner_screens/orders/orders_screen.dart';
import 'inner_screens/wishlist.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  @override
  bool get wantKeepAlive => true;

  User? user = FirebaseAuth.instance.currentUser;
  bool _isLoading = true;
  UserModel? userModel;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } catch (error) {
      await MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "An error has been occurred $error",
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: user == null ? true : false,
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TitleTextWidget(
                    label: "Please login to have unlimited access",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              userModel == null
                  ? const SizedBox.shrink()
                  : Padding(
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
                                color: Colors.lightBlue.shade100,
                                width: 3,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(userModel!.userImage),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleTextWidget(label: userModel!.userName),
                              SubtitleWidget(
                                label: userModel!.userEmail,
                              ),
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
                    user == null
                        ? const SizedBox.shrink()
                        : CustomListTile(
                            imagePath: AssetsManager.orderSvg,
                            text: "All orders",
                            function: () async {
                              await Navigator.pushNamed(
                                  context, OrderScreenFree.routeName);
                            },
                          ),
                    user == null
                        ? const SizedBox.shrink()
                        : CustomListTile(
                            imagePath: AssetsManager.wishlistSvg,
                            text: "Wishlist",
                            function: () async {
                              await Navigator.pushNamed(
                                  context, WishlistScreen.routeName);
                            },
                          ),
                    CustomListTile(
                      imagePath: AssetsManager.recent,
                      text: "Viewed recently",
                      function: () async {
                        await Navigator.pushNamed(
                          context,
                          ViewRecentlyScreen.routeName,
                        );
                      },
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
                  icon: Icon(
                    user == null ? Icons.login : Icons.logout,
                    color: Colors.white,
                  ),
                  label: Text(
                    user == null ? "Login" : "Logout",
                    style: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (null == user) {
                      await Navigator.pushNamed(context, LoginScreen.routeName);
                    } else {
                      await MyAppMethods.showErrorORWarningDialog(
                        context: context,
                        subtitle: "Are you sure?",
                        fct: () async {
                          await FirebaseAuth.instance.signOut();
                          if (!mounted) return;
                          await Navigator.pushNamed(
                              context, LoginScreen.routeName);
                        },
                        isError: false,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
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
