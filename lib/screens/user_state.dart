import 'package:e_commerse/screens/landing_page.dart';
import 'package:e_commerse/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserState extends StatelessWidget {
  const UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (userSnapshot.connectionState == ConnectionState.active) {
          if (userSnapshot.hasData) {
            return MainScreen();
          } else {
            return LandingPage();
          }
        } else {
          return Center(
            child: Text('Error occured'),
          );
        }
      },
    );
  }
}
