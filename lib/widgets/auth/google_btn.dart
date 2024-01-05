import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ionicons/ionicons.dart';
import '../../root_screen.dart';
import '../../services/my_app_method.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> _googleSignIn({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (!context.mounted) return;
      Navigator.of(context).pushReplacementNamed(RootScreen.routeName);
    } on FirebaseException catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: "An error has been occurred ${error.message}",
          fct: () {},
        );
      });
    } catch (error) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: "An error has been occurred $error",
          fct: () {},
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(
          Ionicons.logo_google,
          color: Colors.white,
        ),
        label: const Text(
          "Sign in with Google",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          await _googleSignIn(context: context);
        },
      ),
    );
  }
}
