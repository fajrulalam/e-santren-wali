import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esantrenwali_v1/Classes/AnakSantriClass.dart';
import 'package:esantrenwali_v1/Objects/CurrentUserObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Objects/AnakSantriObject.dart';

class TambahAnakSantri extends StatefulWidget {
  final CurrentUserObject currentUserObject;
  final Function refresh;
  const TambahAnakSantri(
      {Key? key, required this.currentUserObject, required this.refresh})
      : super(key: key);

  @override
  State<TambahAnakSantri> createState() => _TambahAnakSantriState();
}

class _TambahAnakSantriState extends State<TambahAnakSantri> {
  AnakSantriObject anakSantriObject = AnakSantriObject(tglMasuk: Timestamp.now());
  TextEditingController santriIDController = TextEditingController();
  TextEditingController tglLahir = TextEditingController();
  TextEditingController blnLahir = TextEditingController();
  TextEditingController thnLahir = TextEditingController();
  String namaLengkapSantri = '[NAMA]';
  double opacity = 0;
  bool isReadOnly = true;
  @override
  Widget build(BuildContext context) {
    print('build tambah santri');

    return SingleChildScrollView(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Center(
        child: Container(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Tambah Anak Santri',
                      style: GoogleFonts.balooThambi2(
                          fontSize: 28,
                          color: Colors.teal[700],
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  TextField(
                    controller: santriIDController,
                    decoration: InputDecoration(
                      //add rounded border
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Nomor ID anak santri',
                      helperText: 'contoh: DU8291000001',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[300]),
                          onPressed: () async {
                            anakSantriObject =
                                await AnakSantriClass.getDetailAnakSantri(
                                    context, santriIDController.text);
                            //check if anak santri is empty or not
                            if (anakSantriObject.nama == '') {
                              return;
                            }

                            if (anakSantriObject.idWaliSantri?.length == 2) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Sudah terdaftar 2 orang wali untuk ${anakSantriObject.nama}'),
                                duration: Duration(seconds: 2),
                              ));
                              return;
                            }

                            setState(() {
                              namaLengkapSantri = anakSantriObject.nama!;
                              opacity = 1;
                              isReadOnly = false;
                            });
                          },
                          child: Text('Cari')),
                    ],
                  ),
                  SizedBox(height: 20),
                  Opacity(
                    opacity: opacity,
                    child: Column(
                      children: [
                        Text(
                          'Silahkan masukkan tanggal lahir sdr. $namaLengkapSantri',
                          style: GoogleFonts.notoSans(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                readOnly: isReadOnly,
                                controller: tglLahir,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                // controller: emailController,
                                decoration: InputDecoration(
                                  //add rounded border
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Tgl',
                                  helperText: 'cth: 28',
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: TextField(
                                readOnly: isReadOnly,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: blnLahir,
                                // controller: emailController,
                                decoration: InputDecoration(
                                  //add rounded border
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Bln',
                                  helperText: 'cth: 06',
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: TextField(
                                readOnly: isReadOnly,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: thnLahir,
                                // controller: emailController,
                                decoration: InputDecoration(
                                  //add rounded border
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'Thn',
                                  helperText: 'cth: 2005',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Container(
                          height: 40,
                          child: Row(
                            children: [
                              Spacer(),
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      String tanggalLahirLengkap =
                                          '${tglLahir.text}-${blnLahir.text}-${thnLahir.text}';
                                      //convert tanggal lahir ke format DateTime
                                      if (tanggalLahirLengkap !=
                                          anakSantriObject.tglLahir) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              'Tanggal lahir tidak sesuai'),
                                          duration: Duration(seconds: 2),
                                        ));
                                        return;
                                      }

                                      await FirebaseFirestore.instance
                                          .collection('WaliSantriCollection')
                                          .doc(widget.currentUserObject.uid)
                                          .update({
                                        'anakSantriList': FieldValue.arrayUnion(
                                            [anakSantriObject.id!])
                                      });
                                      await FirebaseFirestore.instance
                                          .collection("SantriCollection")
                                          .doc(anakSantriObject.id)
                                          .update({
                                        'idWaliSantri': FieldValue.arrayUnion(
                                            [widget.currentUserObject.uid])
                                      });

                                      widget.refresh();
                                    },
                                    child: Icon(Icons.arrow_forward_outlined)),
                              ),
                            ],
                          ),
                        )
                      ],
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

  void updateDataSantri(DocumentSnapshot<Map<String, dynamic>> value) {
    Map map = value.data() as Map<String, dynamic>;
  }
}
