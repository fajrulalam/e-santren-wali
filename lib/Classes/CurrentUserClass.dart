import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esantrenwali_v1/Objects/CurrentUserObject.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Objects/CurrentUserObject.dart';
import '../Services/Authentication.dart';

class CurrentUserClass {
  final User? user = Auth().currentUser;

  Future<CurrentUserObject> getUserDetail() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    late CurrentUserObject currrentUserObject;

    await db
        .collection("WaliSantriCollection")
        .doc(user?.uid)
        .get()
        .then((value) {
      // get the value and convert it to a map
      Map map = value.data() as Map<String, dynamic>;
      String namaLengkap = map['namaLengkap'].toString();
      List<String> anakSantriList =
          List<String>.from(map['anakSantriList'] as List);
      List<String> asramaList = List<String>.from(map['asramaList'] as List);
      String role = map['role'].toString();

      currrentUserObject = CurrentUserObject(
          uid: user?.uid,
          namaLengkap: namaLengkap,
          anakSantriList: anakSantriList,
          asramaList: asramaList,
          role: role);
    });

    return currrentUserObject;
  }
}
