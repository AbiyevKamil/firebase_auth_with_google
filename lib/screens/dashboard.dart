import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_test/constants/colors.dart';
import 'package:firebase_auth_test/provider/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(fontSize: 25, color: CustomColors.fontColor),
        ),
        backgroundColor: CustomColors.backgroundColor,
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<GoogleSignInProvider>(context, listen: false)
                  .signOutGoogle();
            },
            child: Icon(
              Icons.exit_to_app,
              color: CustomColors.fontColor,
              size: 28,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(user!.photoURL.toString()),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.displayName.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          user.email.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                color: CustomColors.fontColor,
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email verified: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    user.emailVerified
                        ? Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 25,
                          )
                        : Icon(
                            Icons.verified,
                            color: CustomColors.googleColor,
                            size: 25,
                          )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone number: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    user.phoneNumber != null
                        ? Text(
                            user.phoneNumber.toString(),
                            style: TextStyle(fontSize: 18),
                          )
                        : Text(
                            "Not added",
                            style: TextStyle(fontSize: 18),
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
