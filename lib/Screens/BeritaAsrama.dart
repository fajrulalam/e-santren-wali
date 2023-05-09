import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../CustomWidgets/PengumumanWidget.dart';
import '../Objects/CurrentUserObject.dart';

class BeritaAsrama extends StatefulWidget {
  const BeritaAsrama({Key? key}) : super(key: key);

  @override
  State<BeritaAsrama> createState() => _BeritaAsramaState();
}

class _BeritaAsramaState extends State<BeritaAsrama> {
  String kodeAsrama = 'DU15_AlFalah';

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('AktivitasCollection')
              .doc('DU15_AlFalah')
              .collection('PengumumanLogs')
              .orderBy('timestamp', descending: true)
              .limit(10)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            print('length of pengumuman ${snapshot.data!.docs.length}');

            return ListView(
              children: snapshot.data!.docs.map((document) {
                print('apakah ada judul ${document['judul']}');
                return PengumumanContainer(
                  timestamp: document['timestamp'],
                  title: document['judul'],
                  content: document['isi'],
                  imageUrl: document['gambar'],
                  pdfUrl: document['file'],
                );
              }).toList(),
            );
          },
        ));
  }
}
