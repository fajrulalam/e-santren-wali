import 'package:cloud_firestore/cloud_firestore.dart';

class SejarahPulangObject {
  String? alasan;
  String? idPemberiIzin;
  bool? kembaliSesuaiRencana;
  String? pemberiIzin;
  Timestamp? rencanaTanggalKembali;
  bool? sudahKembali;
  bool? sudahSowan;
  Timestamp? tanggalPulang;
  Timestamp? tanggalKembali;

  SejarahPulangObject(
      {this.alasan,
      this.idPemberiIzin,
      this.kembaliSesuaiRencana,
      this.pemberiIzin,
      this.rencanaTanggalKembali,
      this.sudahKembali,
      this.sudahSowan,
      this.tanggalPulang,
      this.tanggalKembali});

  static SejarahPulangObject fromMap(Map data, String id) {
    return SejarahPulangObject(
      alasan: data['alasan'] ?? '',
      idPemberiIzin: data['idPemberiIzin'] ?? '',
      kembaliSesuaiRencana: data['kembaliSesuaiRencana'] ?? false,
      pemberiIzin: data['pemberiIzin'] ?? '',
      rencanaTanggalKembali: data['rencanaTanggalKembali'] ??
          Timestamp.fromMicrosecondsSinceEpoch(0),
      sudahKembali: data['sudahKembali'] ?? false,
      sudahSowan: data['sudahSowan'] ?? false,
      tanggalPulang:
          data['tglPulang'] ?? Timestamp.fromMicrosecondsSinceEpoch(0),
      tanggalKembali:
          data['tanggalKembali'] ?? Timestamp.fromMicrosecondsSinceEpoch(0),
    );
  }
}
