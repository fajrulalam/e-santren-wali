import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApaKabarAnak extends StatefulWidget {
  const ApaKabarAnak({Key? key}) : super(key: key);

  @override
  State<ApaKabarAnak> createState() => _ApaKabarAnakState();
}

class _ApaKabarAnakState extends State<ApaKabarAnak> {
  bool pulangIsExpanded = false;
  bool sakitIsExpanded = false;
  bool statusSPPISExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                  Text('Asrama',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                  Text('Lihat Absensi',
                      style: GoogleFonts.notoSans(
                          fontSize: 12, fontWeight: FontWeight.w400)),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios_outlined,
                      size: 12, color: Colors.grey),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                    'Hafalan: Al-Insiroh',
                    style: GoogleFonts.notoSans(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Text('Lihat Progres',
                      style: GoogleFonts.notoSans(
                          fontSize: 12, fontWeight: FontWeight.w400)),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_forward_ios_outlined,
                      size: 12, color: Colors.grey),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          InkWell(
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
                  Text('3',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                  // const SizedBox(width: 8),
                  // Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                ],
              ),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
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
                                  size: 12, color: Colors.blueAccent)
                            ],
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                ),
              ],
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                  Text('3',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                  const SizedBox(width: 8),
                  Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                  Text('Belum Lunas',
                      style: GoogleFonts.notoSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.red)),
                  const SizedBox(width: 8),
                  Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                  Text('3',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                  Text('3',
                      style: GoogleFonts.notoSans(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
