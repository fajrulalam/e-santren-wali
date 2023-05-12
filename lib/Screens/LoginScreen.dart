import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esantrenwali_v1/Screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Services/Authentication.dart';
import 'WidgetTree.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;

  late Widget body;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'E-Santren',
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: getBody());
  }

  Widget getBody() {
    isLogin
        ? body = Login(
            changeScreen: changeLoginStatus,
          )
        : body = Register(changeScreen: changeLoginStatus);

    return body;
  }

  void changeLoginStatus() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}

class Register extends StatefulWidget {
  final Function changeScreen;
  const Register({
    Key? key,
    required this.changeScreen,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool obscureText = true;

  //create namaLengkap, email, password, and konfirmasiPassword textEditController
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController konfirmasiPassword = TextEditingController();

  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Daftar',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: namaLengkap,
                          decoration: InputDecoration(
                            hintText: 'Nama Lengkap',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: password,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: obscureText
                                      ? Icon(Icons.visibility_off_outlined)
                                      : Icon(Icons.visibility_outlined))),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: konfirmasiPassword,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                              hintText: 'Konfirmasi Password',
                              prefixIcon: Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                  child: obscureText
                                      ? Icon(Icons.visibility_off_outlined)
                                      : Icon(Icons.visibility_outlined))),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              //check if all textEditiingController are not empty
                              if (namaLengkap.text.isEmpty ||
                                  email.text.isEmpty ||
                                  password.text.isEmpty ||
                                  konfirmasiPassword.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Semua field harus diisi'),
                                  ),
                                );
                                return;
                              }

                              //check if password and konfirmasiPassword are same
                              if (password.text != konfirmasiPassword.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Password dan konfirmasi password harus sama'),
                                  ),
                                );
                                return;
                              }

                              _registerWithEmailAndPassword();
                            },
                            child: Text('Daftar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // SizedBox(
                //   width: 215,
                //   height: 50,
                //   child: TextButton(
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.white,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8)),
                //       side: BorderSide(color: Colors.grey),
                //     ),
                //     onPressed: () {
                //       print('google sign in');
                //       _googleSignIn.signIn().then((value) {
                //         value!.authentication.then((googleKey) {
                //           FirebaseAuth.instance
                //               .signInWithCredential(
                //             GoogleAuthProvider.credential(
                //               idToken: googleKey.idToken,
                //               accessToken: googleKey.accessToken,
                //             ),
                //           )
                //               .then((value) {
                //             //check if user is already registered
                //             FirebaseFirestore.instance
                //                 .collection('WaliSantriCollection')
                //                 .doc(value.user!.uid)
                //                 .get()
                //                 .then((snapshot) {
                //               if (snapshot.exists) {
                //                 //user is already registered
                //               } else {
                //                 //user is not registered
                //                 //add user to firestore
                //                 FirebaseFirestore.instance
                //                     .collection('WaliSantriCollection')
                //                     .doc(value.user!.uid)
                //                     .set({
                //                   'anakSantriList': [],
                //                   'email': value.user!.email,
                //                   'namaLengkap': value.user!.displayName,
                //                   'role': 'Wali',
                //                   'timestampRegistrasi': DateTime.now(),
                //                 });
                //               }
                //             });
                //           });
                //         });
                //       });
                //     },
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset(
                //           'images/google_logo.png',
                //           width: 20,
                //           height: 20,
                //         ),
                //         SizedBox(width: 10),
                //         Text(
                //           'Masuk dengan Google',
                //           style: TextStyle(fontSize: 16, color: Colors.black),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    widget.changeScreen();
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Sudah punya akun? ',
                      style: GoogleFonts.poppins(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _registerWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPssword(
          email.text.trim(), password.text, namaLengkap.text);
    } catch (e) {
      //snackbar the short error message
      String errorMessage = e.toString();
      print(errorMessage);
      if (errorMessage
          .contains('The email address is already in use by another account')) {
        errorMessage = 'Email sudah digunakan';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }
}

class Login extends StatefulWidget {
  final Function changeScreen;
  const Login({Key? key, required this.changeScreen}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool tersembunyi = true;
  bool errorIsVisible = false;

  bool isLogin = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
      // Navigator.pushReplacementNamed(context, WidgetTree.id);
    } catch (e) {
      setState(() {
        errorIsVisible = true;
      });
      //await two seconds and then make it false
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          errorIsVisible = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        'images/login_santri.png',
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                    Positioned(
                      //position this bottom center
                      bottom: 35,
                      left: 0,
                      right: 0,
                      child: Center(
                          child: Text(
                        'Selamat datang di aplikasi kami',
                        style: GoogleFonts.balooThambi2(
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                    )
                  ],
                ),
              ),
              Card(
                color: Colors.white,
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text('Login',
                          style: GoogleFonts.balooThambi2(
                              fontSize: 28,
                              color: Colors.teal[700],
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          //add rounded border
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
                        obscureText: tersembunyi,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  tersembunyi = !tersembunyi;
                                });
                              },
                              child: tersembunyi
                                  ? Icon(Icons.visibility_off_outlined)
                                  : Icon(Icons.visibility_outlined)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                          visible: errorIsVisible, child: _errorMessage()),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          signInWithEmailAndPassword();
                          // Navigator.pushNamed(context, HomePage.id);
                        },
                        child: Text('Masuk'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  widget.changeScreen();
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Belum punya akun? ',
                    style: GoogleFonts.poppins(color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Daftar',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _errorMessage() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      child: Text(
        'Email atau Password salah. Silakan coba lagi.',
        style: TextStyle(color: Colors.redAccent, fontSize: 14),
      ),
    );
  }
}
