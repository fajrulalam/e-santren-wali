import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esantrenwali_v1/Objects/SejarahSakitObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Objects/SejarahSakitObject.dart';

class SejarahSakitTerakhirCard extends StatelessWidget {
  final SejarahSakitObject sejarahSakitTerakhir;
  const SejarahSakitTerakhirCard({Key? key, required this.sejarahSakitTerakhir})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNotLate = sejarahSakitTerakhir.sudahPeriksa!;
    bool sudahSembuh = sejarahSakitTerakhir.sudahSembuh!;
    bool isVisible = true;

    // bool sudahSembuh

    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Container(
          child: Material(
            child: Ink(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: isNotLate ? Colors.green : Colors.redAccent,
                      width: 2),
                  borderRadius: BorderRadius.circular(20),
                  color: isNotLate
                      ? Colors.green.withOpacity(0.1)
                      : Colors.redAccent.withOpacity(0.1)),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(sudahSembuh ? 'Sudah Sembuh' : 'Sakit',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: sudahSembuh
                                      ? Colors.green[800]
                                      : Colors.deepOrangeAccent,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/question-mark.png',
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            ' ${sejarahSakitTerakhir.keluhan?.toTitleCase()}',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black38.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'images/due-date-green.png',
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            ' ${convertDate(sejarahSakitTerakhir.updateTimestamp)}',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black38.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Row(
                          children: [
                            Text(
                              'Dirawat di ${sejarahSakitTerakhir.dirawatDi}',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  String countDaysHourDifference(
      Timestamp? tanggalKembali, Timestamp? rencanaTanggalKembali) {
    DateTime? dateTime = tanggalKembali?.toDate();
    DateTime? _rencanaTanggalKembali = rencanaTanggalKembali?.toDate();
    Duration difference = dateTime!.difference(_rencanaTanggalKembali!);
    int days = difference.inDays;
    int hours = difference.inHours % 24 - 1;
    if (days == 0) {
      return '${difference.inHours.toString()}j';
    }
    return '${days.toString()} hari ${hours.toString()} jam';
  }

  String countDaysDifferencewithNow(Timestamp? tanggalKembali) {
    DateTime? dateTime = tanggalKembali?.toDate();
    DateTime now = DateTime.now();
    Duration difference = dateTime!.difference(now);
    int days = difference.inDays;
    if (days == 0) {
      return '${difference.inHours.toString()} jam';
    }
    return '${difference.inDays.toString()} hari';
  }

  static String countDaysDifference(
      Timestamp? tanggalKembali, Timestamp? rencanaTanggalKembali) {
    DateTime? dateTime = tanggalKembali?.toDate();
    DateTime? _rencanaTanggalKembali = rencanaTanggalKembali?.toDate();
    Duration difference = dateTime!.difference(_rencanaTanggalKembali!);
    int days = difference.inDays;
    if (days == 0) {
      return '${difference.inHours.toString()} jam';
    }
    return '${difference.inDays.toString()} hari';
  }

  static String convertDateShort(Timestamp? tanggalKembali) {
    DateTime? dateTime = tanggalKembali?.toDate();
    return DateFormat('dd/MMM/yyyy', 'id').format(dateTime!);
  }

  static String convertDate(String? tanggalKembali_str) {
    //convert tanggal kembali to timestamp
    DateTime? timestamp =
        DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(tanggalKembali_str!);

    return DateFormat('EEEE, dd-MM-yyyy', 'id').format(timestamp!);
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
