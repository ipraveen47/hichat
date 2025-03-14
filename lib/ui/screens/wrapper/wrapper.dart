import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hichat/core/other/user_provider.dart';
import 'package:hichat/ui/screens/auth/login/login_screen.dart';
import 'package:hichat/ui/screens/bottom_navigation/bottom_navigation_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Text("Something Went Wrong");
        }

        if (user == null) {
          return const LoginScreen();
        } else {
          userProvider.loadUser(user.uid);
          return const BottomNavigationScreen();
        }
      },
    );
  }
}
