import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esantrenwali_v1/Objects/SejarahSakitObject.dart';

import '../Objects/SejarahPulangObject.dart';

class SejarahSakitClass {
  static List<SejarahSakitObject> getSejarahSakitSantri(QuerySnapshot event) {
    List<SejarahSakitObject> sejarahSakitList = [];

    if (event.docs.isNotEmpty) {
      for (var element in event.docs) {
        Map data = element.data() as Map<String, dynamic>;
        sejarahSakitList.add(SejarahSakitObject.fromMap(data, element.id));
      }
    }

    return sejarahSakitList;
  }
}
