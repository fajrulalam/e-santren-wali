//Ini yang diambil dari database collection pembayaran search by ID santri
import 'package:cloud_firestore/cloud_firestore.dart';

class SejarahPembayaranObject {
  String? id;
  String? nama;
  String? pembayaranBulan;
  String? tanggalPembayaran;
  String? keterangan;
  String? idPenerima;
  String? diterimaOleh;
  String? kodePenerima;
  int? nominal;
  Uri pdfPath;

  SejarahPembayaranObject(
      {this.id,
        this.nama,
        required this.pdfPath,
        this.pembayaranBulan,
        this.tanggalPembayaran,
        this.idPenerima,
        this.keterangan,
        this.nominal,
        this.kodePenerima,
        this.diterimaOleh});
}

//Ini diambil dari database collection invoice
class InvoiceObject {
  String pembayaranBulan;
  Timestamp tanggalPembuatanInvoice;
  int nominal;

  InvoiceObject(
      this.pembayaranBulan, this.tanggalPembuatanInvoice, this.nominal);
}

//Ini adalah class yang didapatkan setelah memproses invoice2 yang relevan
// 1. bandingkan dengan tanggal santri masuk di asrama dan
// 2. menggunakan indexOf untuk mencari apakah santri sudah membayar

class SejarahPembayaranInvoiceObject {
  String pembayaranBulan;
  String tanggalPembayaran;
  String diterimaOleh;
  int nominal;
  bool lunas;
  String? id;
  String? nama;
  String? keterangan;
  Uri pdfPath;

  SejarahPembayaranInvoiceObject(this.pembayaranBulan, this.tanggalPembayaran,
      this.diterimaOleh, this.nominal, this.lunas,
      {this.id, this.nama, this.keterangan, required this.pdfPath});
}
