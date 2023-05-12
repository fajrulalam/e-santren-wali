import 'package:cloud_firestore/cloud_firestore.dart';

import '../Objects/SejarahPulangObject.dart';

class SejarahPulangClass {
  static List<SejarahPulangObject> getSejarahPulangSantri(QuerySnapshot event) {
    List<SejarahPulangObject> sejarahPulangSantriList = [];

    if (event.docs.isNotEmpty) {
      for (var element in event.docs) {
        Map data = element.data() as Map<String, dynamic>;
        Timestamp rencanaTanggalKembali =
            data['rencanaTanggalKembali'] as Timestamp;
        DateTime rencanaTanggalKembali_dt = rencanaTanggalKembali.toDate();

        if (element['kembaliSesuaiRencana'] == true &&
            rencanaTanggalKembali_dt.isBefore(DateTime.now())) {
          print(
              'rencana tanggal kembali ${data['pemberiIzin']} $rencanaTanggalKembali_dt');
          print(DateTime.now());
          data['kembaliSesuaiRencana'] = false;
        }
        sejarahPulangSantriList
            .add(SejarahPulangObject.fromMap(data, element.id));
      }
    }

    return sejarahPulangSantriList;
  }
}
