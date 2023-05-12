import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInwWithCredential(
      {required String providerId, required String signInMethod}) async {
    await _firebaseAuth.signInWithCredential(
        AuthCredential(providerId: providerId, signInMethod: signInMethod));
  }

  Future<void> createUserWithEmailAndPssword(
      String email, String password, String namaLengkap) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    String uid = userCredential.user!.uid;
    await FirebaseFirestore.instance
        .collection('WaliSantriCollection')
        .doc(uid)
        .set({
      'namaLengkap': namaLengkap,
      'email': email,
      'role': 'Wali',
      'timestampRegistrasi': Timestamp.now(),
      'anakSantriList': [],
      'asramaList': []
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
