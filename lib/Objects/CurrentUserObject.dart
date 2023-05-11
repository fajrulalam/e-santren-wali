class CurrentUserObject {
  String? uid;
  String? namaLengkap;
  List<String>? anakSantriList;
  List<String>? asramaList;
  String role;

  CurrentUserObject(
      {this.uid,
      this.namaLengkap,
      this.anakSantriList,
      this.asramaList,
      required this.role});
}
