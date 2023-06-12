import 'package:cloud_firestore/cloud_firestore.dart';

class PenghargaanPelanggaranObject {
  String id;
  String idSantri;
  String nama;
  String namaPenghargaanAtauPelanggaran;
  bool isPelanggaran;
  String kodeAsrama;
  String dicatatOleh;
  String idPencatat;
  Timestamp timestamp;
  Timestamp? waktuMelanggar;
  String? file;
  bool? sudahDitakzir;
  String lokasi;

  PenghargaanPelanggaranObject({
    required this.id,
    required this.idSantri,
    required this.nama,
    required this.namaPenghargaanAtauPelanggaran,
    required this.isPelanggaran,
    required this.kodeAsrama,
    required this.dicatatOleh,
    required this.idPencatat,
    required this.timestamp,
    required this.lokasi,
    this.waktuMelanggar,
    this.file,
    this.sudahDitakzir,
  });
}
