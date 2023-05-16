import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esantrenwali_v1/Classes/CurrentUserClass.dart';
import 'package:esantrenwali_v1/Objects/AnakSantriObject.dart';
import 'package:esantrenwali_v1/Objects/CurrentUserObject.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Objects/AbsenNgajiKelasObject.dart';

class AbsenCollectionScreen extends StatefulWidget {
  // final AnakSantriObject anakSantriObject;
  // final CurrentUserObject currentUserObject;
  final List<AbsenNgajiKelasObject> absenNgajiKelasList;
  const AbsenCollectionScreen({Key? key, required this.absenNgajiKelasList})
      : super(key: key);

  @override
  State<AbsenCollectionScreen> createState() => _AbsenCollectionScreenState();
}

class _AbsenCollectionScreenState extends State<AbsenCollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absen Kelas'),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.teal[700]),
      ),
      body: Container(
        child: GridView.builder(
          itemCount:
              widget.absenNgajiKelasList.length, // number of items in the grid
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 180,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            childAspectRatio: 0.91,
          ),
          itemBuilder: (BuildContext context, int index) {
            if (widget.absenNgajiKelasList.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              padding: EdgeInsets.all(12),
              child: Card(
                color: _getColor(
                    widget.absenNgajiKelasList[index].kehadiranAnakSantri!),
                elevation: 1,
                //give a rounded corner
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    // Navigator.of(context).push(CustomPageRoute(
                    //     child: CekAbsensi2_Kelas(
                    //       kelas: widget.absenNgajiKelasList[index].kelasNgaji,
                    //       userObject: userObject,
                    //     )));
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
                            widget.absenNgajiKelasList[index]
                                .kehadiranAnakSantri!,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        if (widget.absenNgajiKelasList[index].imagePath! !=
                            'tidak ada foto')
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      child: Image(
                                        image: NetworkImage(widget
                                            .absenNgajiKelasList[index]
                                            .imagePath!),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Expanded(
                              child: Center(
                            child: Container(
                              //Curved corners with radius 4
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.grey[200],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                          )),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dateFormat(
                                  widget.absenNgajiKelasList[index].timestamp!),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
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

  Color _getColor(String kehadiran) {
    //use switch to check for different cases. if Hadir green, if Alfa red, if sakit or izin yellow
    switch (kehadiran) {
      case 'Hadir':
        return Colors.green[100]!;
      case 'Alfa':
        return Colors.red[100]!;
      case 'Sakit':
        return Colors.yellow[100]!;
      case 'Izin':
        return Colors.yellow[100]!;
      default:
        return Colors.white;
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
