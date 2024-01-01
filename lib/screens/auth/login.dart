import 'package:flutter/material.dart';
import 'package:flutter_build_ecommerce/consts/my_validators.dart';
import 'package:flutter_build_ecommerce/widgets/app_name_text.dart';
import 'package:flutter_build_ecommerce/widgets/subtitle_text.dart';
import 'package:flutter_build_ecommerce/widgets/title_text.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../services/my_app_method.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // Focus Node
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // Focus Node
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  Future<void> _loginFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60.0),
                const AppNameTextWidget(fontSize: 30),
                const SizedBox(height: 16.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: TitleTextWidget(label: "Welcome Back!"),
                ),
                const SizedBox(height: 16.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email address",
                          prefixIcon: Icon(IconlyLight.message),
                        ),
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintText: "**********",
                          prefixIcon: const Icon(IconlyLight.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            icon: Icon(obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.passwordValidator(value);
                        },
                        onFieldSubmitted: (value) {
                          _loginFct();
                        },
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const SubtitleWidget(
                            label: "Forgot Password?",
                            textDecoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        // height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            // backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.login, color: Colors.white),
                          label: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            _loginFct();
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      const SubtitleWidget(label: "Or"),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10),
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(
                                Icons.g_mobiledata,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Sign in with Google",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                _loginFct();
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10),
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(
                                Icons.facebook,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Facebook",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                await MyAppMethods.showErrorORWarningDialog(
                                  context: context,
                                  subtitle: "Are you sure?",
                                  fct: () {},
                                  isError: false,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SubtitleWidget(label: "Don't have an account?"),
                          TextButton(
                            onPressed: () {},
                            child: const SubtitleWidget(
                              label: "Sign Up",
                              textDecoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
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
