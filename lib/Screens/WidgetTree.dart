import 'package:esantrenwali_v1/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  CurrentUserObject userDetail = CurrentUserObject(role: '');

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
                if (userDetail.role == 'Bukan Wali Santri') {
                  return Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'E-Santren',
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              child: Text(
                                'Anda tidak terdaftar sebagai Wali Santri',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  _signOut();
                                },
                                child: Text('Logout')),
                          )
                        ],
                      ));
                }
                return HomePage();
              } else {
                return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'E-Santren',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    body: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
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
                    ));
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
    userDetail = await CurrentUserClass().getUserDetail();
    print(userDetail.role);
    if (userDetail.role == 'Wali' ||
        userDetail.role == 'Asrama' ||
        userDetail.role == 'Admin') {
      return true;
    } else {
      return true;
    }
  }

  void _signOut() async {
    try {
      print('signing out');
      await Auth().signOut();
      // SignOut successful, navigate to the home screen
      // Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
