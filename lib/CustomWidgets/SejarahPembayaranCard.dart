import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Objects/SejarahPembayaranObject.dart';

class SejarahPembayaranCard extends StatelessWidget {
  final SejarahPembayaranInvoiceObject sejarahPembayaran;
  const SejarahPembayaranCard({Key? key, required this.sejarahPembayaran})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Ink(
          decoration: BoxDecoration(
              border: Border.all(
                  color:
                      sejarahPembayaran.lunas ? Colors.green : Colors.redAccent,
                  width: 2),
              borderRadius: BorderRadius.circular(20),
              color: sejarahPembayaran.lunas
                  ? Colors.green.withOpacity(0.1)
                  : Colors.redAccent.withOpacity(0.1)),
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        sejarahPembayaran.pembayaranBulan,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (sejarahPembayaran.lunas == true)
                        Text('  (Lunas)',
                            style: GoogleFonts.poppins(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold))
                      else
                        Text(
                          '  (Belum lunas)',
                          style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(
                          sejarahPembayaran.lunas == true
                              ? 'images/due-date-green.png'
                              : 'images/due-date.png',
                          width: 16),
                      SizedBox(width: 8),
                      Text(
                          sejarahPembayaran.lunas
                              ? sejarahPembayaran.tanggalPembayaran.substring(
                                  0,
                                  sejarahPembayaran.tanggalPembayaran.length -
                                      10)
                              : 'Silakan untuk segera membayar',
                          style: GoogleFonts.poppins()),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (sejarahPembayaran.lunas == true)
                    Row(
                      children: [
                        Image.asset('images/bayar-spp.png', width: 16),
                        SizedBox(width: 8),
                        Text(
                            'Nominal Rp ${NumberFormat.decimalPattern().format(sejarahPembayaran.nominal).replaceAll(",", ".")}',
                            style: GoogleFonts.poppins()),
                      ],
                    ),
                  SizedBox(height: 8),
                  if (sejarahPembayaran.lunas == true)
                    Row(
                      children: [
                        Image.asset('images/customer-service.png', width: 16),
                        SizedBox(width: 8),
                        Text('Diterima oleh ${sejarahPembayaran.diterimaOleh}',
                            style: GoogleFonts.poppins()),
                      ],
                    ),
                  SizedBox(height: 8),
                  if (sejarahPembayaran.lunas == true)
                    InkWell(
                      onTap: () {
                        launchURL(sejarahPembayaran.pdfPath);
                      },
                      child: Text('Unduh kwitansi',
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                  SizedBox(height: 8),
                  if (sejarahPembayaran.keterangan != null)
                    Container(
                      child: TextFormField(
                        initialValue: sejarahPembayaran.keterangan,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          labelText: 'Keterangan',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> launchURL(Uri _url) async {
    print(_url);
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }
}
