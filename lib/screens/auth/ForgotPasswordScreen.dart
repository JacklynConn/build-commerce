import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/services/assets_manager.dart';
import 'package:flutter_build_ecommerce/widgets/app_name_text.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../consts/my_validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;
  late final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (mounted) {
      _emailController.dispose();
    }
    super.dispose();
  }

  Future<void> _forgotPasswordFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(
          fontSize: 22,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: ListView(
              children: [
                // Section 1 - Header
                const SizedBox(
                  height: 10,
                ),
                Image.asset(
                  AssetsManager.forgotPassword,
                  width: size.width * 0.6,
                  height: size.width * 0.6,
                ),
                const SizedBox(
                  height: 10,
                ),
                const TitleTextWidget(
                  label: "Forget Password",
                  fontSize: 22,
                ),
                const SubtitleWidget(
                  label:
                      'Please enter your email address you\'d like your password reset information sent to.',
                  fontSize: 14,
                ),
                const SizedBox(
                  height: 40,
                ),

                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "youremail@gmail.com",
                          prefixIcon: Container(
                            padding: const EdgeInsets.all(12.0),
                            child: const Icon(IconlyLight.message),
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          // Move focus to the next field when the "next" button is pressed
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    icon: const Icon(
                      IconlyBold.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: const Text(
                      "Request link",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      _forgotPasswordFct();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
