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
                        Text('Register',
                            style: GoogleFonts.balooThambi2(
                                fontSize: 28,
                                color: Colors.teal[700],
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        TextField(
                          // controller: emailController,
                          decoration: InputDecoration(
                            //add rounded border
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Nomor ID anak santri',
                            helperText: 'contoh: DU8291000001',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal[300]),
                                onPressed: () {},
                                child: Text('Cari')),
                          ],
                        ),
                        SizedBox(height: 20),
                        Opacity(
                          opacity: 1,
                          child: Column(
                            children: [
                              Text(
                                'Silahkan masukkan tanggal lahir sdr. [INSERT NAMA]',
                                style: GoogleFonts.notoSans(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      // controller: emailController,
                                      decoration: InputDecoration(
                                        //add rounded border
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: 'Tgl',
                                        helperText: 'cth: 28',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: TextField(
                                      // controller: emailController,
                                      decoration: InputDecoration(
                                        //add rounded border
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: 'Bln',
                                        helperText: 'cth: 06',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: TextField(
                                      // controller: emailController,
                                      decoration: InputDecoration(
                                        //add rounded border
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        labelText: 'Tgl',
                                        helperText: 'cth: 2005',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Container(
                                height: 40,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: LinearProgressIndicator(
                                        value: 0.5,
                                        backgroundColor: Colors.grey[300],
                                        color: Colors.teal[400],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          onPressed: () {},
                                          child: Icon(
                                              Icons.arrow_forward_outlined)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
