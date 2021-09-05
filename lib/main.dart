import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_test/constants/colors.dart';
import 'package:firebase_auth_test/provider/google_auth.dart';
import 'package:firebase_auth_test/screens/dashboard.dart';
import 'package:firebase_auth_test/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GoogleSignInProvider>(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    color: CustomColors.hintColor,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
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
            } else
              return LoginScreen();
          },
        ),
        theme: ThemeData(
          scaffoldBackgroundColor: CustomColors.backgroundColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: CustomColors.fontColor,
                displayColor: CustomColors.fontColor,
              ),
        ),
      ),
    );
  }
}
