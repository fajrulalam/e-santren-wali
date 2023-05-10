import 'package:esantrenwali_v1/Screens/ApaKabarAnak.dart';
import 'package:esantrenwali_v1/Screens/BayarTagihan.dart';
import 'package:esantrenwali_v1/Screens/BeritaAsrama.dart';
import 'package:esantrenwali_v1/Screens/DonasiAplikasi.dart';
import 'package:esantrenwali_v1/Screens/IzinPulang.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../CustomWidgets/Sidebar.dart';
import '../Services/Authentication.dart';
import 'WidgetTree.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Widget widgetBody = Container();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    returnBody();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Sidebar(
            selectedIndex: _selectedIndex,
            onSelected: (index) {
              setState(() {
                _selectedIndex = index;
                returnBody();
                print(index);
              });
            }),
      ),
      appBar: AppBar(
        title: const Text('Beranda'),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.teal[700]),
      ),
      body: widgetBody,
    );
  }

  void returnBody() {
    setState(() {
      switch (_selectedIndex) {
        case 0:
          widgetBody = ApaKabarAnak();
          break;
        case 1:
          widgetBody = BeritaAsrama();
          break;
        case 2:
          widgetBody = IzinPulang();
          break;
        case 3:
          widgetBody = BayarTagihan();
          break;
        case 4:
          widgetBody = DonasiAplikasi();
          break;
        case 5:
          //sign out and go back to login page
          _signOut();
          break;
        default:
          widgetBody = ApaKabarAnak();
      }
    });
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
