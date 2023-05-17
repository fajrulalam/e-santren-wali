import 'package:esantrenwali_v1/Classes/HafalanClass.dart';
import 'package:esantrenwali_v1/Objects/AnakSantriObject.dart';
import 'package:esantrenwali_v1/Objects/AsramaObject.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Classes/AsramaClass.dart';
import '../Objects/HafalanObject.dart';

class HafalanScreen extends StatefulWidget {
  final AnakSantriObject anakSantriObject;
  const HafalanScreen({Key? key, required this.anakSantriObject})
      : super(key: key);

  @override
  State<HafalanScreen> createState() => _HafalanScreenState();
}

class _HafalanScreenState extends State<HafalanScreen> {
  List<String> hafalanAsrama = [];
  List<HafalanObject> progressHafalan = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHafalan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progres Hafalan'),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.teal[700]),
      ),
      body: progressHafalan.isEmpty
          ? Center(
              child: Text(
                'Belum ada data absen',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
            )
          : Container(
              color: Colors.black54.withOpacity(0.2),
              child: ListView.builder(
                itemCount: hafalanAsrama.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: progressHafalan[index].status! == 'Belum'
                        ? Colors.grey.shade200
                        : Colors.green.shade100,
                    margin: EdgeInsets.only(bottom: 1),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            progressHafalan[index].surat!,
                            style: GoogleFonts.poppins(
                              color: progressHafalan[index].status! == 'Sudah'
                                  ? Colors.green
                                  : Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: Text(
                            progressHafalan[index].status!,
                            style: GoogleFonts.poppins(
                              color: progressHafalan[index].status! == 'Sudah'
                                  ? Colors.green
                                  : Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Divider(
                        //   color: Colors.grey, // Set the color of the divider line
                        //   thickness: 1.0, // Set the thickness of the divider line
                        // ),
                      ],
                    ),
                  );
                },
              )),
    );
  }

  void getHafalan() async {
    AsramaObject asramaDetail =
        await AsramaClass.getAsramaDetail(widget.anakSantriObject.kodeAsrama!);
    List<dynamic> hafalanAsrama_obj = asramaDetail.hafalan!;
    //convert to list of Strings
    hafalanAsrama_obj.forEach((element) {
      hafalanAsrama.add(element.toString());
    });

    List<dynamic> hafalanSantri_obj = widget.anakSantriObject.hafalan!;
    //convert to list of Strings
    List<String> hafalanSantri = [];
    hafalanSantri_obj.forEach((element) {
      hafalanSantri.add(element.toString());
    });

    setState(() {
      progressHafalan =
          HafalanClass.getProgresHafalan(hafalanSantri, hafalanAsrama);
    });
  }
}
