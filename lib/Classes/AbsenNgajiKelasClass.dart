import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esantrenwali_v1/Objects/AbsenNgajiKelasObject.dart';

import '../Objects/AnakSantriObject.dart';

class AbsenNgajiKelasClass {
  static List<AbsenNgajiKelasObject> getAbsenNgajiKelas(
      QuerySnapshot event, AnakSantriObject anakSantriObject) {
    List<AbsenNgajiKelasObject> absenNgajiKelasList = [];

    if (event.docs.isNotEmpty) {
      for (var element in event.docs) {
        Map data = element.data() as Map<String, dynamic>;
        String kehadiranAnakSantri = 'Hadir';

        String identifierAnakSantri =
            '${anakSantriObject.id}, ${anakSantriObject.nama}';

        List hadir = data['hadir'] ?? [];
        List alfa = data['alfa'] ?? [];
        List sakit = data['sakit'] ?? [];
        List izin = data['izin'] ?? [];

        if (alfa.contains(identifierAnakSantri)) kehadiranAnakSantri = 'Alfa';

        if (sakit.contains(identifierAnakSantri)) kehadiranAnakSantri = 'Sakit';

        if (izin.contains(identifierAnakSantri)) kehadiranAnakSantri = 'Izin';

        data['kehadiranAnakSantri'] = kehadiranAnakSantri;

        print('data: $data');

        absenNgajiKelasList
            .add(AbsenNgajiKelasObject.fromMap(data, element.id));
      }
    }

    return absenNgajiKelasList;
  }

  static List<String> getImages(List<AbsenNgajiKelasObject> absenKelas) {
    List<String> images = [];
    for (var element in absenKelas) {
      if (element.imagePath != 'tidak ada foto' && images.length < 3) {
        images.add(element.imagePath!);
      }
    }
    return images;
  }
}
