import 'package:cloud_firestore/cloud_firestore.dart';

class AbsenNgajiKelasObject {
  List? alfa;
  List? hadir;
  String? imagePath;
  List? izin;
  String? kelasNgaji;
  String? kodeAsrama;
  String? pengabsen;
  String? idPengabsen;
  List? sakit;
  String? kehadiranAnakSantri;
  Timestamp? timestamp;
  Timestamp? timestampSelesai;

  AbsenNgajiKelasObject(
      {this.alfa,
      this.hadir,
      this.imagePath,
      this.izin,
      this.kelasNgaji,
      this.kodeAsrama,
      this.pengabsen,
      this.idPengabsen,
      this.sakit,
      this.timestamp,
      this.timestampSelesai,
      this.kehadiranAnakSantri});

  static AbsenNgajiKelasObject fromMap(Map data, String id) {
    return AbsenNgajiKelasObject(
      alfa: data['alfa'] ?? [],
      hadir: data['hadir'] ?? [],
      imagePath: data['imagePath'] ?? '',
      izin: data['izin'] ?? [],
      kelasNgaji: data['kelasNgaji'] ?? '',
      kodeAsrama: data['kodeAsrama'] ?? '',
      pengabsen: data['pengabsen'] ?? '',
      idPengabsen: data['idPengabsen'] ?? '',
      kehadiranAnakSantri: data['kehadiranAnakSantri'] ?? 'tes',
      sakit: data['sakit'] ?? [],
      timestamp: data['timestamp'] ?? Timestamp.fromMillisecondsSinceEpoch(0),
      timestampSelesai:
          data['timestampSelesai'] ?? Timestamp.fromMicrosecondsSinceEpoch(0),
    );
  }
}
