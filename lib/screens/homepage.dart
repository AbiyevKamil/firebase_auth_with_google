import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_test/constants/colors.dart';
import 'package:firebase_auth_test/screens/dashboard.dart';
import 'package:firebase_auth_test/screens/login_screen.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    color: CustomColors.hintColor,
                  ),
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Something went wrong.",
                    style: TextStyle(
                      color: CustomColors.googleColor,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                return Dashboard();
              }
              return LoginScreen();
            default:
              return LoginScreen();
          }
        },
      ),
    );
  }
}
