import 'package:cloud_firestore/cloud_firestore.dart';

import '../Objects/PenghargaanDanPelanggaranObject.dart';

class PenghargaanPelanggaranClass {
  static List<PenghargaanPelanggaranObject> getData(QuerySnapshot snapshot) {
    List<PenghargaanPelanggaranObject> data = [];
    //query from AktivitasCollection/kodeAsrama/PelanggaranDanPenghargaanLogs Firebase
    //and add it to data

    snapshot.docs.forEach((element) {
      Map elementData = element.data() as Map<String, dynamic>;

      Timestamp waktuMelanggar =
          elementData['waktuMelanggar'] ?? elementData['timestamp'];
      String file = elementData['file'] ?? '';
      bool sudahDitakzir = elementData['sudahDiTakzir'] ?? false;
      String lokasi = elementData['lokasi'] ?? 'Asrama';

      PenghargaanPelanggaranObject penghargaanPelanggaranObject =
          PenghargaanPelanggaranObject(
        lokasi: lokasi,
        id: element.id,
        idSantri: elementData['idSantri'] ?? '',
        idPencatat: elementData['idPencatat'] ?? '',
        nama: elementData['nama'] ?? '',
        namaPenghargaanAtauPelanggaran:
            elementData['namaPenghargaanAtauPelanggaran'] ?? '',
        isPelanggaran: elementData['isPelanggaran'] ?? '',
        kodeAsrama: elementData['kodeAsrama'] ?? '',
        dicatatOleh: elementData['dicatatOleh'] ?? '',
        timestamp: elementData['timestamp'] ?? Timestamp(0, 0),
        waktuMelanggar: waktuMelanggar,
        file: file,
        sudahDitakzir: sudahDitakzir,
      );
      data.add(penghargaanPelanggaranObject);
    });

    return data;
  }
}
