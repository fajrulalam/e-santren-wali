import 'package:esantrenwali_v1/CustomWidgets/SejarahPulangTerakhirCard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Objects/SejarahPulangObject.dart';

class SejarahPulangCollection extends StatefulWidget {
  final List<SejarahPulangObject> sejarahPulangList;
  const SejarahPulangCollection({Key? key, required this.sejarahPulangList})
      : super(key: key);

  @override
  State<SejarahPulangCollection> createState() =>
      _SejarahPulangCollectionState();
}

class _SejarahPulangCollectionState extends State<SejarahPulangCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sejarah Pulang'),
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.teal[700]),
        ),
        body: widget.sejarahPulangList.isEmpty
            ? Center(
                child: Text(
                  'Belum ada data absen',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            : Container(
                child: ListView.builder(
                    itemCount: widget.sejarahPulangList.length,
                    itemBuilder: (context, index) {
                      print(
                          'tes ${widget.sejarahPulangList[index].kembaliSesuaiRencana!}');
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SejarahPulangTerakhirCard(
                            sejarahPulangTerakhir:
                                widget.sejarahPulangList[index]),
                      );
                    }),
              ));
  }
}
