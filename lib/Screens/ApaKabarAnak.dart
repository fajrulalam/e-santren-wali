import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ApaKabarAnak extends StatefulWidget {
  const ApaKabarAnak({Key? key}) : super(key: key);

  @override
  State<ApaKabarAnak> createState() => _ApaKabarAnakState();
}

class _ApaKabarAnakState extends State<ApaKabarAnak> {
  bool pulangIsExpanded = false;
  bool sakitIsExpanded = false;
  bool statusSPPISExpanded = false;
  List<dynamic> images = [
    'https://firebasestorage.googleapis.com/v0/b/e-santren.appspot.com/o/fotoAsrama%2FDU15_AlFalah%2F119882119_763492927557577_1523352540989159613_n.jpg?alt=media&token=346298b2-6bb8-4022-9af4-2211283fd099',
    'https://firebasestorage.googleapis.com/v0/b/e-santren.appspot.com/o/fotoAsrama%2FDU15_AlFalah%2F336938993_651619936974045_8726345547016895210_n.jpg?alt=media&token=07db0de4-9119-4d2c-baf3-f9e819a77a5a',
    'https://firebasestorage.googleapis.com/v0/b/e-santren.appspot.com/o/fotoAsrama%2FDU15_AlFalah%2F187651795_311304787296674_4376420471911140793_n.jpg?alt=media&token=d3658d7c-dbff-414c-bc1f-f71ad8c1ccec'
  ];

  //Data Terakhir Pulang

  @override
  Widget build(BuildContext context) {
    bool sppLunas = true;
    bool isHadir = false;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              child: PageView.builder(
                //give indicator that the user can swipe
                controller:
                    PageController(viewportFraction: 0.85, initialPage: 1),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                //show snackbar for 2 seconds
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Terakhir diperbarui 2 jam yang lalu'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                //add border top and bottom
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: .5, color: Colors.grey.shade300),
                    bottom: BorderSide(width: .5, color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('images/location.png', width: 32),
                    const SizedBox(width: 16),
                    Text(
                      'Keberadaan',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: isHadir
                            ? Colors.green
                            : Colors.orangeAccent.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(isHadir ? 'Di Pondok' : 'Tidak di Pondok',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                //add border top and bottom
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: .5, color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('images/recite.png', width: 32),
                    const SizedBox(width: 16),
                    Text(
                      'Hari ini mengaji',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    // Text('Lihat Absensi',
                    //     style: GoogleFonts.notoSans(
                    //         fontSize: 12, fontWeight: FontWeight.w400)),
                    // const SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios_outlined,
                        size: 12, color: Colors.grey),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                //add border top and bottom
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: .5, color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('images/rising.png', width: 32),
                    const SizedBox(width: 12),
                    Text(
                      'Hafalan:',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Al-Insiroh',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Spacer(),
                    // Text('Lihat Progres',
                    //     style: GoogleFonts.notoSans(
                    //         fontSize: 12, fontWeight: FontWeight.w400)),
                    const SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios_outlined,
                        size: 12, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                //add border on the top and bottom
                border: Border(
                  top: BorderSide(width: .5, color: Colors.grey.shade300),
                  bottom: BorderSide(width: .5, color: Colors.grey.shade300),
                ),
              ),
              child: InkWell(
                onTap: () {},
                child: ExpansionTile(
                  trailing: Icon(
                    pulangIsExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 16,
                    color: Colors.grey,
                  ),
                  title: Row(
                    children: [
                      Image.asset('images/house.png', width: 32),
                      const SizedBox(width: 16),
                      Text(
                        'Berapa kali pulang',
                        style: GoogleFonts.notoSans(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipOval(
                          child: Container(
                            width: 23,
                            height: 23,
                            color: Colors.grey.shade300,
                            child: Center(
                              child: Text(
                                '2',
                                style: GoogleFonts.poppins(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(width: 8),
                      // Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Row(
                        children: [
                          Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Text(
                                  'Lihat data lenkap',
                                  style: GoogleFonts.notoSans(
                                      color: Colors.blueAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward,
                                    size: 12, color: Colors.blueAccent),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                    ),
                  ],
                ),
              ),
            ),
            if (pulangIsExpanded)
              AnimatedContainer(
                duration: Duration(milliseconds: 2000),
                color: Colors.redAccent,
                height: pulangIsExpanded ? 200 : 0,
              ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                //add border top and bottom
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: .5, color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('images/healthcare.png', width: 32),
                    const SizedBox(width: 16),
                    Text(
                      'Sejarah Sakit',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipOval(
                        child: Container(
                          width: 23,
                          height: 23,
                          color: Colors.grey.shade300,
                          child: Center(
                            child: Text(
                              '0',
                              style: GoogleFonts.poppins(
                                  color: Colors.black87, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.keyboard_arrow_down,
                        size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                //add border top and bottom
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: .5, color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('images/receipt.png', width: 32),
                    const SizedBox(width: 16),
                    Text(
                      'Status SPP',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: sppLunas
                            ? Colors.green
                            : Colors.redAccent.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(sppLunas ? 'Lunas' : 'Belum Lunas',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.keyboard_arrow_down,
                        size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                //add border top and bottom
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: .5,
                      color: Colors.grey.shade300,
                    ),
                    top: BorderSide(
                      width: .5,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('images/badge.png', width: 32),
                    const SizedBox(width: 16),
                    Text(
                      'Penghargaan',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Color(0xFFF57F17),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipOval(
                        child: Container(
                          color: Color(0xFFFBC02D),
                          width: 23,
                          height: 23,
                          child: Center(
                            child: Text(
                              '2',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                //add border top and bottom
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: .5, color: Colors.grey.shade300),
                  ),
                ),
                child: Row(
                  children: [
                    Image.asset('images/referee.png', width: 32),
                    const SizedBox(width: 16),
                    Text(
                      'Pelanggaran',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.shade400,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipOval(
                        child: Container(
                          width: 23,
                          height: 23,
                          color: Colors.redAccent,
                          child: Center(
                            child: Text(
                              '2',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  static String convertDate(Timestamp? tanggalKembali) {
    DateTime? dateTime = tanggalKembali?.toDate();
    return DateFormat('EEEE, dd-MM-yyyy', 'id').format(dateTime!);
  }

  static String convertDateShort(Timestamp? tanggalKembali) {
    DateTime? dateTime = tanggalKembali?.toDate();
    return DateFormat('dd/MMM/yyyy', 'id').format(dateTime!);
  }
}
