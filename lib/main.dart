import 'package:firebase_auth_test/constants/colors.dart';
import 'package:firebase_auth_test/provider/google_auth.dart';
import 'package:firebase_auth_test/screens/homepage.dart';
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
        home: Homepage(),
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
