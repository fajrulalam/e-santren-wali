import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esantrenwali_v1/Classes/CurrentUserClass.dart';
import 'package:esantrenwali_v1/Objects/AnakSantriObject.dart';
import 'package:esantrenwali_v1/Objects/CurrentUserObject.dart';
import 'package:esantrenwali_v1/Objects/PenghargaanDanPelanggaranObject.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Objects/AbsenNgajiKelasObject.dart';

class PenghargaanDanPelanggaranScreen extends StatefulWidget {
  // final AnakSantriObject anakSantriObject;
  // final CurrentUserObject currentUserObject;
  final List<PenghargaanPelanggaranObject> penghargaanAtauPelanggaran;
  final bool isPelanggaran;
  const PenghargaanDanPelanggaranScreen(
      {Key? key,
      required this.penghargaanAtauPelanggaran,
      required this.isPelanggaran})
      : super(key: key);

  @override
  State<PenghargaanDanPelanggaranScreen> createState() =>
      _AbsenCollectionScreenState();
}

class _AbsenCollectionScreenState
    extends State<PenghargaanDanPelanggaranScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPelanggaran
            ? 'Sejarah Pelanggaran'
            : 'Koleksi Penghargaan'),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.teal[700]),
      ),
      body: Container(
        child: widget.penghargaanAtauPelanggaran.isEmpty
            ? Center(
                child: Text(
                  widget.isPelanggaran
                      ? 'Belum ada data pelanggaran'
                      : 'Belum ada data penghargaan',
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            : GridView.builder(
                itemCount: widget.penghargaanAtauPelanggaran
                    .length, // number of items in the grid
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  childAspectRatio: 9 / 12,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (widget.penghargaanAtauPelanggaran.isEmpty) {
                    return Center(
                      child: Text(widget.isPelanggaran
                          ? 'Belum ada data pelanggaran'
                          : 'Belum ada data penghargaan'),
                    );
                  }

                  return Container(
                    padding: EdgeInsets.all(12),
                    child: Card(
                      color: _getColor(widget.isPelanggaran),
                      elevation: 1,
                      //give a rounded corner
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (widget.penghargaanAtauPelanggaran[index].file! !=
                              '') {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: '',
                              transitionDuration: Duration(milliseconds: 200),
                              pageBuilder: (context, animation1, animation2) {
                                return Center(
                                  child: Stack(
                                    children: [
                                      InteractiveViewer(
                                        child: Image.network(
                                          widget
                                              .penghargaanAtauPelanggaran[index]
                                              .file!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.grey,
                                            shape: CircleBorder(),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: Text(
                                  widget.penghargaanAtauPelanggaran[index]
                                      .namaPenghargaanAtauPelanggaran!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Spacer(),
                              if (widget.penghargaanAtauPelanggaran[index]
                                      .file! !=
                                  '')
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight: 110,
                                    ),
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4)),
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            widget
                                                .penghargaanAtauPelanggaran[
                                                    index]
                                                .file!,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Center(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight: 110,
                                    ),
                                    //Curved corners with radius 4
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.grey[200],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Icon(
                                            Icons.no_photography_outlined,
                                            size: 40,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            'Tidak ada foto',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dateFormat(widget
                                        .penghargaanAtauPelanggaran[index]
                                        .timestamp!),
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      widget.penghargaanAtauPelanggaran[index]
                                          .dicatatOleh!
                                          .replaceAll("Ustadz", "Ust")
                                          .replaceAll("Ustadzah", "Ustz"),
                                      maxLines: 1,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Color _getColor(bool kehadiran) {
    //use switch to check for different cases. if Hadir green, if Alfa red, if sakit or izin yellow

    if (kehadiran) {
      return Colors.green[100]!;
    } else {
      return Colors.red[100]!;
    }
  }

  String dateFormat(Timestamp timestamp) {
    //make a format EEEE, dd-mm-yyyy with id locale
    var format = DateFormat('EEEE, dd-MM-yy', 'id');
    //format the timestamp to that format
    var date = format.format(timestamp.toDate());
    //return the date
    return date;
  }
}
