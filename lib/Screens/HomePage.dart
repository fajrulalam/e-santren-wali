import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esantrenwali_v1/Classes/CurrentUserClass.dart';
import 'package:esantrenwali_v1/CustomWidgets/LoaderWidget.dart';
import 'package:esantrenwali_v1/CustomWidgets/TambahAnakSantri.dart';
import 'package:esantrenwali_v1/Objects/AnakSantriObject.dart';
import 'package:esantrenwali_v1/Objects/CurrentUserObject.dart';
import 'package:esantrenwali_v1/Screens/ApaKabarAnak.dart';
import 'package:esantrenwali_v1/Screens/BayarTagihan.dart';
import 'package:esantrenwali_v1/Screens/BeritaAsrama.dart';
import 'package:esantrenwali_v1/Screens/DonasiAplikasi.dart';
import 'package:esantrenwali_v1/Screens/IzinPulang.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Classes/AnakSantriClass.dart';
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
  CurrentUserObject currentUserObject = CurrentUserObject(role: 'Wali');
  AnakSantriObject anakSantriObject = AnakSantriObject();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    returnBody();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: currentUserObject == CurrentUserObject(role: 'Wali')
          ? Container()
          : currentUserObject.anakSantriList?.isEmpty ?? true
              ? Container()
              : Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Sidebar(
                      anakSantriObject: anakSantriObject,
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

  void returnBody() async {
    // LoaderWidget.showLoader(context);
    print('getting user detail...');
    currentUserObject = await CurrentUserClass().getUserDetail();
    print('berhasil dapatin anak santri ${currentUserObject.namaLengkap}');
    // Navigator.pop(context);
    if (currentUserObject.anakSantriList!.isEmpty) {
      print('building tambah santri...');
      setState(() {
        widgetBody = TambahAnakSantri(
            currentUserObject: currentUserObject, refresh: () => returnBody());
      });
      print('built tambah anak santri');

      return;
    }

    anakSantriObject = await AnakSantriClass.getDetailAnakSantri(
        context, currentUserObject.anakSantriList![0]);

    setState(() {
      switch (_selectedIndex) {
        case 0:
          widgetBody = ApaKabarAnak(
              anakSantriObject: anakSantriObject,
              currentUserObject: currentUserObject);
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
          widgetBody = ApaKabarAnak(
              anakSantriObject: anakSantriObject,
              currentUserObject: currentUserObject);
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
