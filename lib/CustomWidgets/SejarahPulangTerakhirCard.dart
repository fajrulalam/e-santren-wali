import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Objects/SejarahPulangObject.dart';

class SejarahPulangTerakhirCard extends StatelessWidget {
  final SejarahPulangObject sejarahPulangTerakhir;
  const SejarahPulangTerakhirCard(
      {Key? key, required this.sejarahPulangTerakhir})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNotLate = sejarahPulangTerakhir.kembaliSesuaiRencana!;
    bool isVisible = true;

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
                          Text(getStatusPulang(sejarahPulangTerakhir),
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: isNotLate
                                      ? Colors.green[800]
                                      : Colors.redAccent,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            isNotLate
                                ? 'images/due-date-green.png'
                                : 'images/deadline.png',
                            height: 24,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            ' ${convertDate(sejarahPulangTerakhir.rencanaTanggalKembali)}',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black38.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            isNotLate
                                ? ' (sisa ${countDaysDifferencewithNow(sejarahPulangTerakhir.rencanaTanggalKembali)} lagi)'
                                : ' (terlambat ${countDaysDifferencewithNow(sejarahPulangTerakhir.rencanaTanggalKembali).replaceAll('-', '')})',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: isNotLate
                                    ? Colors.green[800]
                                    : Colors.redAccent,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4,
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
                            ' ${sejarahPulangTerakhir.alasan}',
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
                              'Masa izin ${convertDateShort(sejarahPulangTerakhir.tanggalPulang)} - ${convertDateShort(sejarahPulangTerakhir.rencanaTanggalKembali)}',
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

  static String convertDate(Timestamp? tanggalKembali) {
    DateTime? dateTime = tanggalKembali?.toDate();
    return DateFormat('EEEE, dd-MM-yyyy', 'id').format(dateTime!);
  }

  String getStatusPulang(SejarahPulangObject sejarahPulangTerakhir) {
    if (sejarahPulangTerakhir.kembaliSesuaiRencana == false &&
        sejarahPulangTerakhir.sudahKembali == true)
      return 'Sudah kembali, tapi terlambat.';

    if (sejarahPulangTerakhir.kembaliSesuaiRencana == true &&
        sejarahPulangTerakhir.sudahKembali == true)
      return 'Sudah kembali, dan tepat waktu!';

    if (sejarahPulangTerakhir.kembaliSesuaiRencana == true &&
        sejarahPulangTerakhir.sudahKembali == false)
      return 'Izin masih berlangsung...';

    if (sejarahPulangTerakhir.kembaliSesuaiRencana == false &&
        sejarahPulangTerakhir.sudahKembali == false)
      return 'Sudah waktunya kembali ke pondok!';

    return 'Detail Izin Pulang';

    // if (sejarahPulangTerakhir.sudahKembali == false) return 'Belum Kembali';
  }
}
