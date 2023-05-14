import 'package:cloud_firestore/cloud_firestore.dart';

class SejarahSakitObject {
  String id;
  String nama;
  String imagePath;
  String tanggal;
  bool sudahAdaDetail;
  String? keluhan;
  String? dirawatDi;
  String? keterangan;
  bool? sudahPeriksa;
  bool? sudahSembuh;
  String? periksaDi;
  int? suhuTubuh;
  String? tensi;
  bool? lunasSPP;
  String? diagnosa;
  String? preskripsi;
  String? updateTimestamp;

  SejarahSakitObject(
      this.id, this.nama, this.imagePath, this.tanggal, this.sudahAdaDetail,
      {this.keluhan,
      this.keterangan,
      this.sudahSembuh,
      this.dirawatDi,
      this.lunasSPP,
      this.sudahPeriksa,
      this.periksaDi,
      this.suhuTubuh,
      this.tensi,
      this.diagnosa,
      this.preskripsi,
      this.updateTimestamp});

  static SejarahSakitObject fromMap(Map data, String id) {
    return SejarahSakitObject(
      id,
      data['nama'] ?? '',
      data['imagePath'] ?? '',
      data['tanggal'] ?? '',
      data['sudahAdaDetail'] ?? false,
      keluhan: data['keluhan'] ?? '',
      sudahSembuh: data['sudahSembuh'] ?? false,
      dirawatDi: data['dirawatDi'] ?? '',
      keterangan: data['keterangan'] ?? '',
      sudahPeriksa: data['sudahPeriksa'] ?? false,
      periksaDi: data['periksaDi'] ?? '',
      suhuTubuh: data['suhuTubuh'] ?? 0,
      tensi: data['tensi'] ?? '',
      lunasSPP: data['lunasSPP'] ?? false,
      diagnosa: data['diagnosa'] ?? '',
      preskripsi: data['preskripsi'] ?? '',
      updateTimestamp: data['updateTimestamp'] ?? '',
    );
  }
}
