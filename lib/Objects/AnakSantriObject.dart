import 'package:cloud_firestore/cloud_firestore.dart';

class AnakSantriObject {
  String? id;
  Timestamp tglMasuk;
  String? tglLahir;
  String? nama;
  String? kamar;
  String? kelasNgaji;
  String? kelas;
  String? pathFotoProfil;
  String? pembayaranTerakhir;
  String? statusAktif;
  List<dynamic>? idWaliSantri;
  List<dynamic>? hafalan;
  String? absenNgaji;
  String? alamat;
  String? jenisKelamin;
  String? jenjangPendidikan;
  String? kodeAsrama;
  String? kotaAsal;
  bool? lunasSPP;
  String? namaWali;
  String? noHP;
  String? statusKehadiran;
  Map<String, dynamic>? statusKesehatan;
  Map<String, dynamic>? statusKepulangan;

  AnakSantriObject(
      {this.id,
      required this.tglMasuk,
      this.tglLahir,
      this.nama,
      this.kamar,
      this.kelasNgaji,
      this.hafalan,
      this.kelas,
      this.pathFotoProfil,
      this.pembayaranTerakhir,
      this.statusAktif,
      this.idWaliSantri,
      this.absenNgaji,
      this.alamat,
      this.jenisKelamin,
      this.jenjangPendidikan,
      this.kodeAsrama,
      this.kotaAsal,
      this.lunasSPP,
      this.namaWali,
      this.noHP,
      this.statusKehadiran,
      this.statusKesehatan,
      this.statusKepulangan});
}
