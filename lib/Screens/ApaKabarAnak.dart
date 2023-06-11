import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:esantrenwali_v1/Classes/AnakSantriClass.dart';
import 'package:esantrenwali_v1/Classes/SejarahPulangClass.dart';
import 'package:esantrenwali_v1/CustomWidgets/SejarahPembayaranCard.dart';
import 'package:esantrenwali_v1/Objects/AbsenNgajiKelasObject.dart';
import 'package:esantrenwali_v1/Objects/AnakSantriObject.dart';
import 'package:esantrenwali_v1/Objects/AsramaObject.dart';
import 'package:esantrenwali_v1/Objects/CurrentUserObject.dart';
import 'package:esantrenwali_v1/Objects/SejarahPulangObject.dart';
import 'package:esantrenwali_v1/Objects/SejarahSakitObject.dart';
import 'package:esantrenwali_v1/Screens/HafalanScreen.dart';
import 'package:esantrenwali_v1/Screens/SejarahPulangCollection.dart';
import 'package:esantrenwali_v1/Screens/SejarahSakitCollection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Classes/AbsenNgajiKelasClass.dart';
import '../Classes/SejarahPembayaranClass.dart';
import '../Classes/SejarahSakitClass.dart';
import '../CustomWidgets/SejarahPulangTerakhirCard.dart';
import '../CustomWidgets/SejarahSakitTerakhirCard.dart';
import '../Objects/SejarahPembayaranObject.dart';
import '../Services/CustomPageRouteAnimation.dart';
import 'AbsenCollectionScreen.dart';

class ApaKabarAnak extends StatefulWidget {
  final CurrentUserObject currentUserObject;
  final AnakSantriObject anakSantriObject;
  const ApaKabarAnak(
      {Key? key,
      required this.currentUserObject,
      required this.anakSantriObject})
      : super(key: key);

  @override
  State<ApaKabarAnak> createState() =>
      _ApaKabarAnakState(currentUserObject, anakSantriObject);
}

class _ApaKabarAnakState extends State<ApaKabarAnak> {
  CurrentUserObject currentUserObject;
  AnakSantriObject anakSantriObject;

  _ApaKabarAnakState(this.currentUserObject, this.anakSantriObject);

  String keberadaan = '...';
  String hariIniMengaji = '...';
  String hafalan = '...';
  int berapaKaliPulang = 0;
  int berapaKaliSakit = 0;
  int jumlahPenghargaan = 0;
  int JumlahPelanggaran = 0;
  bool sppLunas = true;
  bool isHadir = false;

  List<SejarahPulangObject> sejarahPulang = [];
  List<SejarahPembayaranInvoiceObject> sejarahPembayaran = [];
  List<SejarahSakitObject> sejarahSakit = [];
  List<AbsenNgajiKelasObject> absenKelas = [];
  // List<SejarahPembayaranInvoiceObject> dataSejarahPembayaranInvoice = [];

  IconData arrowIconSejarahPulang = Icons.keyboard_arrow_down;

  bool pulangIsExpanded = false;
  bool sakitIsExpanded = false;
  bool statusSPPISExpanded = false;
  List<String> images = [
    'https://firebasestorage.googleapis.com/v0/b/e-santren.appspot.com/o/fotoAsrama%2FDU15_AlFalah%2F119882119_763492927557577_1523352540989159613_n.jpg?alt=media&token=346298b2-6bb8-4022-9af4-2211283fd099',
    'https://firebasestorage.googleapis.com/v0/b/e-santren.appspot.com/o/fotoAsrama%2FDU15_AlFalah%2F336938993_651619936974045_8726345547016895210_n.jpg?alt=media&token=07db0de4-9119-4d2c-baf3-f9e819a77a5a',
    'https://firebasestorage.googleapis.com/v0/b/e-santren.appspot.com/o/fotoAsrama%2FDU15_AlFalah%2F187651795_311304787296674_4376420471911140793_n.jpg?alt=media&token=d3658d7c-dbff-414c-bc1f-f71ad8c1ccec'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataStream();
  }

  @override
  Widget build(BuildContext context) {
    // if (sejarahPulang.isNotEmpty) {
    //   print(sejarahPulang[0].kembaliSesuaiRencana);
    // }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        color: Colors.teal[100],
        child: Stack(
          children: [
            Container(
              //make bottom corners curved
              decoration: BoxDecoration(),
              padding: EdgeInsets.only(top: 20),
              height: 185,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //cicular avatar from image network
                  CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage(
                      anakSantriObject.pathFotoProfil!,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      child: Text(
                        anakSantriObject.nama!,
                        style: GoogleFonts.balooThambi2(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        anakSantriObject.id!,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.balooThambi2(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 185,
                  ),
                  Container(
                    //make top corners curved
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //drop shadow on the top
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        // bottomLeft: Radius.circular(30),
                        // bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              int hours = 0;

                              //show snackbar for 2 seconds
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.teal[100],
                                  content: Text(
                                    anakSantriObject.statusKehadiran!,
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              //add border top and bottom
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: .5, color: Colors.grey.shade300),
                                  bottom: BorderSide(
                                      width: .5, color: Colors.grey.shade300),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset('images/location.png', width: 32),
                                  const SizedBox(width: 16),
                                  Text(
                                    'Keberadaan',
                                    style: GoogleFonts.notoSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: isHadir
                                          ? Colors.green
                                          : Colors.orangeAccent
                                              .withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                        isHadir
                                            ? 'Di Pondok'
                                            : 'Tidak di Pondok',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              print('tapped');
                              Navigator.of(context).push(CustomPageRoute(
                                  child: AbsenCollectionScreen(
                                      absenNgajiKelasList: absenKelas)));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              //add border top and bottom
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: .5, color: Colors.grey.shade300),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset('images/recite.png', width: 32),
                                  const SizedBox(width: 16),
                                  Text(
                                    hariIniMengaji,
                                    style: GoogleFonts.notoSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
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
                        ),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(CustomPageRoute(
                                  child: HafalanScreen(
                                      anakSantriObject: anakSantriObject)));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              //add border top and bottom
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: .5, color: Colors.grey.shade300),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset('images/rising.png', width: 32),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Hafalan:',
                                    style: GoogleFonts.notoSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      hafalan,
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
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
                        ),
                        SizedBox(height: 16),
                        // Divider(
                        //   height: 0,
                        //   thickness: 1,
                        //   color: Colors.grey.shade300,
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,

                            //add border radius on all corners
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          height: 182,
                          child: PageView.builder(
                            //give indicator that the user can swipe
                            controller: PageController(
                                viewportFraction: 0.7, initialPage: 1),
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            //add border on the top and bottom
                            border: Border(
                              top: BorderSide(
                                  width: .5, color: Colors.grey.shade300),
                              bottom: BorderSide(
                                  width: .5, color: Colors.grey.shade300),
                            ),
                          ),
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                print('tapped');
                                setState(() {
                                  // pulangIsExpanded = !pulangIsExpanded;
                                  // arrowIconSejarahPulang = pulangIsExpanded
                                  //     ? Icons.keyboard_arrow_up
                                  //     : Icons.keyboard_arrow_down;
                                });
                              },
                              child: ExpansionTile(
                                trailing: Icon(
                                  arrowIconSejarahPulang,
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: ClipOval(
                                        child: Container(
                                          width: 23,
                                          height: 23,
                                          color: Colors.grey.shade300,
                                          child: Center(
                                            child: Text(
                                              berapaKaliPulang.toString(),
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black87,
                                                  fontSize: 12),
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
                                  if (sejarahPulang.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: SejarahPulangTerakhirCard(
                                          sejarahPulangTerakhir:
                                              sejarahPulang[0]),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 16),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                CustomPageRoute(
                                                    child:
                                                        SejarahPulangCollection(
                                              sejarahPulangList: sejarahPulang,
                                            )));
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'Lihat data lenkap',
                                                style: GoogleFonts.notoSans(
                                                    color: Colors.blueAccent,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(width: 8),
                                              Icon(Icons.arrow_forward,
                                                  size: 12,
                                                  color: Colors.blueAccent),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (pulangIsExpanded)
                          AnimatedContainer(
                            duration: Duration(milliseconds: 2000),
                            color: Colors.redAccent,
                            height: pulangIsExpanded ? 200 : 0,
                          ),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              //add border top and bottom
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: .5, color: Colors.grey.shade300),
                                ),
                              ),
                              child: ExpansionTile(
                                trailing: Icon(
                                  arrowIconSejarahPulang,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                title: Row(
                                  children: [
                                    Image.asset('images/healthcare.png',
                                        width: 32),
                                    const SizedBox(width: 16),
                                    Text(
                                      'Sejarah Sakit',
                                      style: GoogleFonts.notoSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: ClipOval(
                                        child: Container(
                                          width: 23,
                                          height: 23,
                                          color: Colors.grey.shade300,
                                          child: Center(
                                            child: Text(
                                              berapaKaliSakit.toString(),
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black87,
                                                  fontSize: 12),
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
                                  if (sejarahSakit.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: SejarahSakitTerakhirCard(
                                          sejarahSakitTerakhir:
                                              sejarahSakit[0]),
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0.0, horizontal: 16),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                CustomPageRoute(
                                                    child:
                                                        SejarahSakitCollection(
                                              sejarahSakitList: sejarahSakit,
                                            )));
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'Lihat data lenkap',
                                                style: GoogleFonts.notoSans(
                                                    color: Colors.blueAccent,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(width: 8),
                                              Icon(Icons.arrow_forward,
                                                  size: 12,
                                                  color: Colors.blueAccent),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // child: Row(
                              //   children: [
                              //     Image.asset('images/healthcare.png',
                              //         width: 32),
                              //     const SizedBox(width: 16),
                              //     Text(
                              //       'Sejarah Sakit',
                              //       style: GoogleFonts.notoSans(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w500),
                              //     ),
                              //     Spacer(),
                              //     Container(
                              //       width: 24,
                              //       height: 24,
                              //       padding: const EdgeInsets.all(1),
                              //       decoration: BoxDecoration(
                              //         color: Colors.black87,
                              //         borderRadius: BorderRadius.circular(100),
                              //       ),
                              //       child: ClipOval(
                              //         child: Container(
                              //           width: 23,
                              //           height: 23,
                              //           color: Colors.grey.shade300,
                              //           child: Center(
                              //             child: Text(
                              //               berapaKaliSakit.toString(),
                              //               style: GoogleFonts.poppins(
                              //                   color: Colors.black87,
                              //                   fontSize: 12),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     const SizedBox(width: 8),
                              //     Icon(Icons.keyboard_arrow_down,
                              //         size: 16, color: Colors.grey),
                              //   ],
                              // ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              //add border top and bottom
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: .5, color: Colors.grey.shade300),
                                ),
                              ),
                              child: ExpansionTile(
                                trailing: Icon(
                                  arrowIconSejarahPulang,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                title: Row(
                                  children: [
                                    Image.asset('images/receipt.png',
                                        width: 32),
                                    const SizedBox(width: 16),
                                    Text(
                                      'Status SPP',
                                      style: GoogleFonts.notoSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: sppLunas
                                            ? Colors.green
                                            : Colors.redAccent.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                          sppLunas ? 'Lunas' : 'Belum Lunas',
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white)),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                                children: [
                                  if (sejarahPembayaran.isNotEmpty)
                                    SejarahPembayaranCard(
                                        sejarahPembayaran:
                                            sejarahPembayaran[0]),
                                  if (sejarahPembayaran.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 16),
                                      child: Row(
                                        children: [
                                          Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  CustomPageRoute(
                                                      child:
                                                          SejarahPulangCollection(
                                                sejarahPulangList:
                                                    sejarahPulang,
                                              )));
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Lihat data lenkap',
                                                  style: GoogleFonts.notoSans(
                                                      color: Colors.blueAccent,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(width: 8),
                                                Icon(Icons.arrow_forward,
                                                    size: 12,
                                                    color: Colors.blueAccent),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
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
                                            jumlahPenghargaan.toString(),
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
                        ),
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              //add border top and bottom
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: .5, color: Colors.grey.shade300),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Image.asset('images/referee.png', width: 32),
                                  const SizedBox(width: 16),
                                  Text(
                                    'Pelanggaran',
                                    style: GoogleFonts.notoSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
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
                                            JumlahPelanggaran.toString(),
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
                        ),
                        SizedBox(height: 36),
                      ],
                    ),
                  ),
                ],
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

  void getDataStream() {
    Stream<DocumentSnapshot> anakSantriStream = FirebaseFirestore.instance
        .collection("SantriCollection")
        .doc(anakSantriObject.id)
        .snapshots();

    anakSantriStream.listen((event) {
      setState(() {
        anakSantriObject = AnakSantriClass.fromMap(event, anakSantriObject.id!);

        // print(anakSantriObject.hafalan);

        hafalan =
            anakSantriObject.hafalan![anakSantriObject.hafalan!.length - 1]!;

        sppLunas = anakSantriObject.lunasSPP!;

        anakSantriObject.absenNgaji == 'Hadir'
            ? hariIniMengaji = 'Hari ini mengaji'
            : hariIniMengaji = 'Hari ini tidak mengaji';

        isHadir = anakSantriObject.statusKehadiran == 'Hadir' ||
            anakSantriObject.statusKehadiran == 'Ada';
      });
    });

    //make a stream of a collection firebase firestore SantriCollection/anakSantriObject.id/SakitCollection
    Stream<QuerySnapshot> sakitCollectionStream = FirebaseFirestore.instance
        .collection("SantriCollection")
        .doc(anakSantriObject.id)
        .collection("SakitCollection")
        .orderBy('updateTimestamp', descending: true)
        .snapshots();

    sakitCollectionStream.listen((event) {
      setState(() {
        berapaKaliSakit = event.docs.length;
        sejarahSakit = SejarahSakitClass.getSejarahSakitSantri(event);
        print('sejarahSakitLength ${sejarahSakit.length}');
      });
    });

    //make a stream of a collection firebase firestore SantriCollection/anakSantriObject.id/IzinPulangCollection
    Stream<QuerySnapshot> izinPulangCollectionStream = FirebaseFirestore
        .instance
        .collection("SantriCollection")
        .doc(anakSantriObject.id)
        .collection("IzinPulangCollection")
        .orderBy('timestamp', descending: true)
        .snapshots();

    izinPulangCollectionStream.listen((event) {
      setState(() {
        berapaKaliPulang = event.docs.length;
        sejarahPulang = SejarahPulangClass.getSejarahPulangSantri(event);
      });
    });

    Stream<QuerySnapshot> absenNgajiSnapshot = FirebaseFirestore.instance
        .collection("AktivitasCollection")
        .doc(anakSantriObject.kodeAsrama)
        .collection("AbsenNgajiLogs")
        .where('kelasNgaji', isEqualTo: anakSantriObject.kelasNgaji)
        .orderBy('timestamp', descending: true)
        .snapshots();

    absenNgajiSnapshot.listen((event) {
      setState(() {
        absenKelas =
            AbsenNgajiKelasClass.getAbsenNgajiKelas(event, anakSantriObject);
        images = AbsenNgajiKelasClass.getImages(absenKelas) + images;
      });
    });

    Stream<QuerySnapshot> pembayaranCollectionStream = FirebaseFirestore
        .instance
        .collection("SantriCollection")
        .doc(anakSantriObject.id)
        .collection("PembayaranCollection")
        .orderBy('timestamp', descending: true)
        .snapshots();

    pembayaranCollectionStream.listen((event) async {
      Timestamp tanggalMasuk = anakSantriObject.tglMasuk!;
      String idTerpilih = anakSantriObject.id!;
      String kodeAsrama = anakSantriObject.kodeAsrama!;

      sejarahPembayaran = await SejarahPembayaranClass()
          .getSejarahPembayaranInvoice(idTerpilih, tanggalMasuk, kodeAsrama);

      sejarahPembayaran
          .sort((a, b) => b.tanggalPembayaran!.compareTo(a.tanggalPembayaran!));

      print('sejarahPembayaranLength ${sejarahPembayaran.length}');
      setState(() {});
    });
  }
}
