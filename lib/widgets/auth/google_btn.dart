import 'package:cloud_firestore/cloud_firestore.dart';
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
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount == null) return;
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResults =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      if (authResults.additionalUserInfo!.isNewUser) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(authResults.user!.uid)
            .set({
          "userId": authResults.user!.uid,
          "userName": authResults.user!.displayName,
          "userImage": authResults.user!.photoURL,
          "userEmail": authResults.user!.email!.toLowerCase(),
          "createdAt": Timestamp.now(),
          'userWish': [],
          'userCart': [],
        });
      }
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
