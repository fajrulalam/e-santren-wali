import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esantrenwali_v1/Objects/AnakSantriObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnakSantriClass {
  static Future<AnakSantriObject> getDetailAnakSantri(
      BuildContext context, String id) async {
    AnakSantriObject anakSantriObject = AnakSantriObject();

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('SantriCollection')
        .doc(id)
        .get();

    if (documentSnapshot.exists) {
      Map map = documentSnapshot.data() as Map<String, dynamic>;
      anakSantriObject = AnakSantriObject(
        id: id,
        tglLahir: map['tglLahir'],
        nama: map['nama'],
        kamar: map['kamar'],
        kelas: map['kelas'],
        kelasNgaji: map['kelasNgaji'],
        pathFotoProfil: map['pathFotoProfil'],
        pembayaranTerakhir: map['pembayaranTerakhir'],
        statusAktif: map['statusAktif'],
        idWaliSantri: map['idWaliSantri'],
        absenNgaji: map['absenNgaji'],
        alamat: map['alamat'] ?? '',
        jenisKelamin: map['jenisKelamin'] ?? '',
        jenjangPendidikan: map['jenjangPendidikan'] ?? '',
        kodeAsrama: map['kodeAsrama'] ?? '',
        kotaAsal: map['kotaAsal'] ?? '',
        lunasSPP: map['lunasSPP'] ?? false,
        hafalan: map['hafalan'] ?? [],
        namaWali: map['namaWali'] ?? '',
        noHP: map['noHP'] ?? '',
        statusKehadiran: map['statusKehadiran'] ?? 'Tidak Ada',
        statusKesehatan: map['statusKesehatan'] ?? {},
        statusKepulangan: map['statusKepulangan'] ?? {},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('ID santri tidak ditemukan'),
        duration: Duration(seconds: 2),
      ));
    }

    return anakSantriObject;
  }

  static AnakSantriObject fromMap(
      DocumentSnapshot documentSnapshot, String id) {
    Map map = documentSnapshot.data() as Map<String, dynamic>;

    return AnakSantriObject(
      id: id,
      tglLahir: map['tglLahir'],
      nama: map['nama'],
      kamar: map['kamar'],
      kelas: map['kelas'],
      kelasNgaji: map['kelasNgaji'],
      pathFotoProfil: map['pathFotoProfil'],
      pembayaranTerakhir: map['pembayaranTerakhir'],
      statusAktif: map['statusAktif'],
      idWaliSantri: map['idWaliSantri'],
      absenNgaji: map['absenNgaji'],
      alamat: map['alamat'] ?? '',
      jenisKelamin: map['jenisKelamin'] ?? '',
      jenjangPendidikan: map['jenjangPendidikan'] ?? '',
      kodeAsrama: map['kodeAsrama'] ?? '',
      kotaAsal: map['kotaAsal'] ?? '',
      hafalan: map['hafalan'] ?? [],
      lunasSPP: map['lunasSPP'] ?? false,
      namaWali: map['namaWali'] ?? '',
      noHP: map['noHP'] ?? '',
      statusKehadiran: map['statusKehadiran'] ?? 'Tidak Ada',
      statusKesehatan: map['statusKesehatan'] ?? {},
      statusKepulangan: map['statusKepulangan'] ?? {},
    );
  }
}
