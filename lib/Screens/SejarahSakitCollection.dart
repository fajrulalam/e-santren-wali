import 'package:esantrenwali_v1/CustomWidgets/SejarahSakitTerakhirCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Objects/SejarahSakitObject.dart';

class SejarahSakitCollection extends StatefulWidget {
  final List<SejarahSakitObject> sejarahSakitList;
  const SejarahSakitCollection({Key? key, required this.sejarahSakitList})
      : super(key: key);

  @override
  State<SejarahSakitCollection> createState() => _SejarahSakitCollectionState();
}

class _SejarahSakitCollectionState extends State<SejarahSakitCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sejarah Pulang'),
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.teal[700]),
        ),
        body: widget.sejarahSakitList.isEmpty
            ? Center(
                child: Text(
                  'Belum ada data absen',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            : Container(
                child: ListView.builder(
                    itemCount: widget.sejarahSakitList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SejarahSakitTerakhirCard(
                            sejarahSakitTerakhir:
                                widget.sejarahSakitList[index]),
                      );
                    }),
              ));
  }
}
