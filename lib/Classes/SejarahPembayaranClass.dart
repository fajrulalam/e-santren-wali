import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Objects/CurrentUserObject.dart';
import '../Objects/SejarahPembayaranObject.dart';
import 'CurrentUserClass.dart';

class SejarahPembayaranClass {
  late List<SejarahPembayaranObject> _dataPembayaranSantri = [];

  late List<InvoiceObject> dataInvoice = [];

  late List<SejarahPembayaranInvoiceObject> dataSejarahPembayaranInvoice = [];

  set dataPembayaranSantri(List<SejarahPembayaranObject> value) {
    _dataPembayaranSantri = value;
  } //ini nanti yang dikirim ke ListView

  int jumlahTagihan = 0;

  Future<List<SejarahPembayaranInvoiceObject>> getSejarahPembayaranInvoice(
      String id, Timestamp tglMasuk, String kodeAsrama) async {
    CurrentUserObject currentUserObject =
        await CurrentUserClass().getUserDetail();

    //Ambil data sejarah pembayaran seorang santri (id = id) dari nested Collection
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('SantriCollection')
        .doc(id)
        .collection('PembayaranCollection')
        .get();

    querySnapshot.docs.forEach((element) {
      //turn element to map
      Map<String, dynamic> elementMap = element.data() as Map<String, dynamic>;

      SejarahPembayaranObject sejarahPembayaranObject = SejarahPembayaranObject(
          pdfPath: Uri.parse(elementMap['pdfPembayaran'] ?? ''),
          pembayaranBulan: elementMap['namaPembayaran'],
          tanggalPembayaran: elementMap['timestamp'],
          diterimaOleh: elementMap['diterimaOleh']);

      _dataPembayaranSantri.add(sejarahPembayaranObject);

      print('SUDAH DIBAYAR ${element['namaPembayaran']}');
    });

    //Ambil data invoice dari InvoiceCollection
    QuerySnapshot querySnapshot_inv = await FirebaseFirestore.instance
        .collection('InvoiceCollection')
        .where('kodeAsrama', isEqualTo: kodeAsrama)
        .where('tglInvoice', isGreaterThan: tglMasuk)
        .orderBy('tglInvoice', descending: false)
        .get();

    querySnapshot_inv.docs.forEach((doc) {
      InvoiceObject invoiceObject =
          InvoiceObject(doc.id, doc['tglInvoice'], doc['nominal']);

      dataInvoice.add(invoiceObject);
    });

    int index;
    dataInvoice.forEach((bulanInvoice) {
      index = _dataPembayaranSantri.indexWhere(
          (element) => element.pembayaranBulan == bulanInvoice.pembayaranBulan);

      print('PERHATIKAN INI: ${bulanInvoice.pembayaranBulan} $index');

      try {
        print('${bulanInvoice.pembayaranBulan} ${_dataPembayaranSantri[0]}');
      } catch (e) {
        print(e);
      }

      if (index == -1) {
        dataSejarahPembayaranInvoice.add(SejarahPembayaranInvoiceObject(
            bulanInvoice.pembayaranBulan,
            "Belum dibayar",
            "",
            bulanInvoice.nominal,
            false,
            pdfPath: Uri.parse('')));
        return;
      }

      if (_dataPembayaranSantri[index].keterangan != null) {
        print('MASUK SINI: ${_dataPembayaranSantri[index].pembayaranBulan!}');
        dataSejarahPembayaranInvoice.add(SejarahPembayaranInvoiceObject(
            _dataPembayaranSantri[index].pembayaranBulan!,
            _dataPembayaranSantri[index].tanggalPembayaran!,
            _dataPembayaranSantri[index].diterimaOleh!,
            pdfPath: _dataPembayaranSantri[index].pdfPath,
            keterangan: _dataPembayaranSantri[index].keterangan!,
            bulanInvoice.nominal,
            true));
        return;
      }

      dataSejarahPembayaranInvoice.add(SejarahPembayaranInvoiceObject(
          _dataPembayaranSantri[index].pembayaranBulan!,
          _dataPembayaranSantri[index].tanggalPembayaran!,
          _dataPembayaranSantri[index].diterimaOleh!,
          pdfPath: _dataPembayaranSantri[index].pdfPath,
          bulanInvoice.nominal,
          true));
    });

    return dataSejarahPembayaranInvoice;
  }

  int getJumlahTagihan(
      List<SejarahPembayaranInvoiceObject> hitungJumlahTagihan) {
    int jumlahTagihan = 0;
    hitungJumlahTagihan.forEach((element) {
      if (element.lunas == false) {
        jumlahTagihan++;
      }
    });

    return jumlahTagihan;
  }

// Future<List<SejarahPembayaranObject>> getSejarahPembayaranFuture(String id) async {
//   //get data from firebase of this id from SantriCollection and nested in SejarahPembayaranCollection
//   //then return the data
//
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//       .collection('SantriCollection').doc(id).collection('SejarahPembayaranCollection')
//       .get();
//
//   querySnapshot.docs.forEach((element) {
//     SejarahPembayaranObject sejarahPembayaranObject=SejarahPembayaranObject(
//         pembayaranBulan: element['pembayaranBulan'],
//         tanggalPembayaran: element['tanggalPembayaran'],
//         diterimaOleh: element['diterimaOleh'],
//         keterangan: element['keterangan']);
//
//     _dataPembayaranSantri.add(sejarahPembayaranObject);
//   });
//
//
//   return _dataPembayaranSantri;
// }
//
// List<SejarahPembayaranObject> getDataPaymentHistory(String id) {
//   _dataPembayaranSantri.clear();
//   switch (id) {
//     case 'DU15230001':
//       _dataPembayaranSantri = <SejarahPembayaranObject>[
//         SejarahPembayaranObject(
//             pembayaranBulan: 'November 2022',
//             tanggalPembayaran: '12-11-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Desember 2022',
//             tanggalPembayaran: '05-12-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Januari 2023',
//             tanggalPembayaran: '15-01-2023',
//             diterimaOleh: "Mundzir",
//             keterangan: "sekalian bayar untuk bulan depan"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Februari 2023',
//             tanggalPembayaran: '25-02-2023',
//             diterimaOleh: "Mundzir",
//             keterangan: "sudah lunas sejak bulan lalu")
//       ];
//       break;
//     case 'DU15230002':
//       _dataPembayaranSantri = <SejarahPembayaranObject>[
//         // SejarahPembayaranObject(
//         //     pembayaranBulan: 'November 2022',
//         //     tanggalPembayaran: '12-11-2022',
//         //     diterimaOleh: "Udin"),
//         // SejarahPembayaranObject(
//         //     pembayaranBulan: 'Desember 2022',
//         //     tanggalPembayaran: '05-12-2022',
//         //     diterimaOleh: "Mundzir"),
//         // SejarahPembayaranObject(
//         //     pembayaranBulan: 'Januari 2023',
//         //     tanggalPembayaran: '15-01-2023',
//         //     diterimaOleh: "Mumtaz"),
//       ];
//       break;
//     case 'DU15230003':
//       _dataPembayaranSantri = <SejarahPembayaranObject>[
//         SejarahPembayaranObject(
//             pembayaranBulan: 'November 2022',
//             tanggalPembayaran: '12-11-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Desember 2022',
//             tanggalPembayaran: '05-12-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Januari 2023',
//             tanggalPembayaran: '15-01-2023',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Februari 2023',
//             tanggalPembayaran: '25-12-2023',
//             diterimaOleh: "Mundzir")
//       ];
//       break;
//     case 'DU15230004':
//       _dataPembayaranSantri = <SejarahPembayaranObject>[
//         SejarahPembayaranObject(
//             pembayaranBulan: 'November 2022',
//             tanggalPembayaran: '12-11-2022',
//             diterimaOleh: "Mumtaz"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Desember 2022',
//             tanggalPembayaran: '05-12-2022',
//             diterimaOleh: "Shobari"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Januari 2023',
//             tanggalPembayaran: '15-01-2023',
//             diterimaOleh: "Shobari"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Februari 2023',
//             tanggalPembayaran: '25-12-2023',
//             diterimaOleh: "Shobari")
//       ];
//       break;
//     case 'DU15230005':
//       _dataPembayaranSantri = <SejarahPembayaranObject>[
//         SejarahPembayaranObject(
//             pembayaranBulan: 'November 2022',
//             tanggalPembayaran: '12-11-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Desember 2022',
//             tanggalPembayaran: '05-12-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Januari 2023',
//             tanggalPembayaran: '15-01-2023',
//             diterimaOleh: "Shobari",
//             keterangan: "sekalian bayar untuk bulan depan"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Februari 2023',
//             tanggalPembayaran: '25-12-2023',
//             diterimaOleh: "Mundzir",
//             keterangan: "sudah lunas sejak bulan lalu")
//       ];
//       break;
//     case 'DU15230006':
//       _dataPembayaranSantri = <SejarahPembayaranObject>[
//         SejarahPembayaranObject(
//             pembayaranBulan: 'November 2022',
//             tanggalPembayaran: '12-11-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Januari 2023',
//             tanggalPembayaran: '15-01-2023',
//             diterimaOleh: "Shobari"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Februari 2023',
//             tanggalPembayaran: '25-12-2023',
//             diterimaOleh: "Mundzir")
//       ];
//       break;
//     case 'DU15230007':
//       _dataPembayaranSantri = <SejarahPembayaranObject>[
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Desember 2022',
//             tanggalPembayaran: '05-12-2022',
//             diterimaOleh: "Mumtaz"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Januari 2023',
//             tanggalPembayaran: '15-01-2023',
//             diterimaOleh: "Shobari"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Februari 2023',
//             tanggalPembayaran: '25-12-2023',
//             diterimaOleh: "Mundzir")
//       ];
//       break;
//     case 'DU15230008':
//       _dataPembayaranSantri = <SejarahPembayaranObject>[
//         SejarahPembayaranObject(
//             pembayaranBulan: 'November 2022',
//             tanggalPembayaran: '12-11-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Desember 2022',
//             tanggalPembayaran: '05-12-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Januari 2023',
//             tanggalPembayaran: '15-01-2023',
//             diterimaOleh: "Mundzir",
//             keterangan: "sekalian bayar untuk bulan depan"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Februari 2023',
//             tanggalPembayaran: '25-12-2023',
//             diterimaOleh: "Mundzir",
//             keterangan: "sudah lunas sejak bulan lalu")
//       ];
//       break;
//     case 'DU15230009':
//       _dataPembayaranSantri = <SejarahPembayaranObject>[
//         SejarahPembayaranObject(
//             pembayaranBulan: 'November 2022',
//             tanggalPembayaran: '12-11-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Desember 2022',
//             tanggalPembayaran: '05-12-2022',
//             diterimaOleh: "Shobari"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Februari 2023',
//             tanggalPembayaran: '25-12-2023',
//             diterimaOleh: "Mundzir")
//       ];
//       break;
//     case 'DU15230010':
//       _dataPembayaranSantri = <SejarahPembayaranObject>[
//         SejarahPembayaranObject(
//             pembayaranBulan: 'November 2022',
//             tanggalPembayaran: '12-11-2022',
//             diterimaOleh: "Shobari"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Desember 2022',
//             tanggalPembayaran: '05-12-2022',
//             diterimaOleh: "Mundzir"),
//         SejarahPembayaranObject(
//             pembayaranBulan: 'Februari 2023',
//             tanggalPembayaran: '25-12-2023',
//             diterimaOleh: "Mumtaz")
//       ];
//       break;
//   }
//
//   return _dataPembayaranSantri;
// }
//
// List<InvoiceObject> getInvoiceList() {
//   //Function ini nanti menerima TglMasukSantri sebagai parameter.
//   //Parameter tersebut akan digunakan untuk memilih tagihan mana saja yang relevan untuk ditampilkan
//
//   dataInvoice = <InvoiceObject>[
//     InvoiceObject('Februari 2023', '01-02-2023', 250000),
//     InvoiceObject('Januari 2023', '01-01-2023', 250000),
//     InvoiceObject('Desember 2022', '01-12-2022', 250000),
//     InvoiceObject('November 2022', '01-11-2022', 250000),
//   ];
//
//   return dataInvoice;
// }
}
