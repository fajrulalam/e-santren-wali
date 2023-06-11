import 'package:esantrenwali_v1/CustomWidgets/SejarahPembayaranCard.dart';
import 'package:esantrenwali_v1/Objects/SejarahPembayaranObject.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Objects/SejarahPulangObject.dart';

class SejarahPembayaranColelction extends StatefulWidget {
  final List<SejarahPembayaranInvoiceObject> sejarahPembayaran;
  const SejarahPembayaranColelction({Key? key, required this.sejarahPembayaran})
      : super(key: key);

  @override
  State<SejarahPembayaranColelction> createState() =>
      _SejarahPembayaranColelctionState();
}

class _SejarahPembayaranColelctionState
    extends State<SejarahPembayaranColelction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sejarah Pembayaran'),
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.teal[700]),
        ),
        body: widget.sejarahPembayaran.isEmpty
            ? Center(
                child: Text(
                  'Belum ada data absen',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                    itemCount: widget.sejarahPembayaran.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SejarahPembayaranCard(
                            sejarahPembayaran: widget.sejarahPembayaran[index]),
                      );
                    }),
              ));
  }
}
