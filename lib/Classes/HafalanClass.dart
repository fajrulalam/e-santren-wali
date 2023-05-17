import '../Objects/HafalanObject.dart';

class HafalanClass {
  static List<HafalanObject> getProgresHafalan(
      List<String> hafalanSantri, List<String> hafalanAsrama) {
    List<HafalanObject> hafalanList = [];

    String status;
    hafalanAsrama.forEach((element) {
      status = hafalanSantri.indexOf(element) == -1 ? 'Belum' : 'Sudah';

      hafalanList.add(HafalanObject(surat: element, status: status));
    });

    return hafalanList;
  }
}
