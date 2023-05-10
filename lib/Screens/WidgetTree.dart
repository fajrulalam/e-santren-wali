import 'package:esantrenwali_v1/Screens/HomePage.dart';
import 'package:flutter/material.dart';

import '../Classes/CurrentUserClass.dart';
import '../Objects/CurrentUserObject.dart';
import '../Services/Authentication.dart';
import 'LoginScreen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);
  static const String id = 'widget-tree';

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('user is logged in');
          return FutureBuilder(
            future: checkIfUserIsVerified(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              //check if the snapshot contains the value true
              if (snapshot.hasData && snapshot.data == true) {
                return HomePage();
              } else {
                return Container(
                  color: Colors.white,
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator()),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Loading...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        } else {
          print('user is not logged in');
          return LoginScreen();
        }
      },
    );
  }

  Future<bool> checkIfUserIsVerified() async {
    print("getting user detail");
    CurrentUserObject userDetail = await CurrentUserClass().getUserDetail();
    print(userDetail.role);
    if (userDetail.role == 'Wali' ||
        userDetail.role == 'Asrama' ||
        userDetail.role == 'Admin') {
      return true;
    } else {
      return false;
    }
  }
}
