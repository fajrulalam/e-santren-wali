import 'package:esantrenwali_v1/Screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/Authentication.dart';
import 'WidgetTree.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool tersembunyi = true;
  bool errorIsVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Halaman Login',
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      child: Image.asset(
                        'images/login_santri.png',
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
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
                    onPressed: () {},
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
            )));
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text);
      Navigator.pushReplacementNamed(context, WidgetTree.id);
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